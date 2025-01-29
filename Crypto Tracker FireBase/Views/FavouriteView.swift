//
//  FavouriteView.swift
//  Crypto Tracker FireBase
//
//  Created by Sai bharadwaj Adapa on 1/23/25.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct FavouriteView: View {
    
    let db = Firestore.firestore()
    
    @State var fetchedCoins: [CryptoModel] = []
    
    var body: some View {
        Text("Favourites")
            .bold()
            .font(.largeTitle)
        VStack{
            List(fetchedCoins){ l in
                
                NavigationLink {
                    DetailView(selectedCoin: l)
                } label: {
                    VStack(spacing: 8){
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.white)
                                .shadow(radius: 5)
                                .frame(height: 50)
                            
                            HStack{
         
                                AsyncImage(url: URL(string: l.image ?? "image")) { image in
                                        image
                                            .resizable()
                                            .frame(width:50,height:50)
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width:50,height:50)
                                    }
         
                                Text(l.name ?? "coin")
                                    .bold()
                                    .padding(.leading)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                        }.listRowSeparator(.hidden)
                      
                    }
                    .swipeActions {
                        Button(role: .destructive){
                            
                            Task{
                                do {
                                    try await db.collection("coins").document(l.id ?? "id").delete()
                                  print("Document successfully removed!")
                                } catch {
                                  print("Error removing document: \(error)")
                                }
                            }
                            
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                }

               
            }
            .listStyle(.plain)
            
            
            
        }
        .task{
            do {
              let querySnapshot = try await db.collection("coins").getDocuments()
              for document in querySnapshot.documents {
                  let data = document.data()
                  
                  let coin = CryptoModel(
                                    id: document.documentID,
                                    name: data["name"] as? String,
                                    image: data["image"] as? String,
                                    current_price: data["current_price"] as? Double,
                                    market_cap_rank: data["market_cap_rank"] as? Int,
                                    high_24h: data["high_24h"] as? Double,
                                    low_24h: data["low_24h"] as? Double
                                )
                  
                  fetchedCoins.append(coin)
                  
              }
            } catch {
              print("Error getting documents: \(error)")
            }
        }
        
        Spacer()
    }
}

#Preview {
    FavouriteView()
}
