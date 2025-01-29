//
//  ContentView.swift
//  Crypto Tracker FireBase
//
//  Created by Sai bharadwaj Adapa on 1/23/25.
//

import SwiftUI

struct ContentView: View {
    var service = DataService()
    @State var cryptoData : [CryptoModel] = [CryptoModel]()
//    @State var itemVisible : Bool = false
//    @State var selectedItem : CryptoModel?
    var body: some View {
        VStack {
          
    
            NavigationStack{
                HStack(spacing:90){
                    Spacer()
                    Text("CrypTo")
                         .font(.largeTitle)
                         .bold()
                    NavigationLink {
                        FavouriteView()
                    } label: {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 40))
                            .padding(.trailing)
                            .foregroundStyle(.black)
                    }

                    
                   
                }
                
                List(cryptoData){ c in
                    
                   NavigationLink {
                       DetailView(selectedCoin: c)
                    } label: {
                        VStack(spacing: 8){
                            ZStack{
                                
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(.white)
                                    .shadow(radius: 5)
                                    .frame(height: 50)
                                
                                HStack{
                                    
                                   
                                        
                                    AsyncImage(url: URL(string: c.image ?? "image")) { image in
                                            image
                                                .resizable()
                                                .frame(width:50,height:50)
                                        } placeholder: {
                                            ProgressView()
                                                .frame(width:50,height:50)
                                        }

                                    Text(c.name ?? "coin name")
                                        .bold()
                                        .padding(.leading)
                                    
                                    Spacer()
                                }
                                .padding(.horizontal)
                                
                            }.listRowSeparator(.hidden)
                          
                        }
                    }
  
        
                }
                .ignoresSafeArea()
                .listStyle(.plain)
                
            Spacer()
            }
            
            
            
        }
        
        .task{
            cryptoData = await service.getData()
            print(cryptoData)
        }
        
        
    }
}

#Preview {
    ContentView()
}
