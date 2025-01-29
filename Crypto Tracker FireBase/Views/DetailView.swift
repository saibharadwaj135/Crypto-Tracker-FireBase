//
//  DetailView.swift
//  Crypto Tracker FireBase
//
//  Created by Sai bharadwaj Adapa on 1/23/25.
//



import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct DetailView: View {
    
    @State var selectedCoin : CryptoModel
    let db = Firestore.firestore()
    
    var body: some View {
        
       
            
        AsyncImage(url: URL(string: selectedCoin.image ?? "image")) { Image in
                Image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:200,height:200)
                
            } placeholder: {
                ProgressView()
                    .frame(width: 100,height: 100)
            }
        
        Text(selectedCoin.name ?? "coin-name")
            .font(.largeTitle)
            .bold()
            .padding(.top,30)
        
        Text("Price: $\(String(format: "%.2f", selectedCoin.current_price ?? 0.0))")
            .font(.title)
            .bold()
        
        
        VStack(alignment:.leading,spacing: 10){
            Text("Market Rank: \(selectedCoin.market_cap_rank ?? 0)")
                .font(.title2)
              
            
            Text("Highest Last 24Hrs: $\(String(format: "%.2f", selectedCoin.high_24h ?? 0.0))")
                .font(.title2)
            
            Text("Lowest Last 24Hrs: $\(String(format: "%.2f", selectedCoin.low_24h ?? 0.0))")
                .font(.title2)
        }
        .padding(.top,20)
        
        Button {
            
            do {
                try db.collection("coins").document(selectedCoin.id ?? "id").setData(from: selectedCoin)
            } catch let error {
              print("Error writing city to Firestore: \(error)")
            }
            
        } label: {
            
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width:200, height:50)
                    
                    Text("Add to Favorite")
                        .foregroundStyle(.white)
                        .bold()
                }
                
             
            }
            .padding(.top,30)
            
            
        }

       

      //  Text(String(format: "%.3f", selectedCoin.price ?? 0.0))
        Spacer()
    }
}

#Preview {
    DetailView(selectedCoin: CryptoModel())
}
