//
//  DataService.swift
//  Crypto Tracker FireBase
//
//  Created by Sai bharadwaj Adapa on 1/23/25.
//

import Foundation

struct DataService{
    
    func getData() async -> [CryptoModel] {
        
        if let url  = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd"){
            
            var request = URLRequest(url : url)
            
            request.addValue("CG-QfB42mbdDcBHTRqsPFmmZYsv", forHTTPHeaderField: "x-cg-demo-api-key")
            request.addValue("application/json" , forHTTPHeaderField: "accept")
            
            do{
                let (data,response) = try await URLSession.shared.data(for: request)
                print(data)
                
                let decoder = JSONDecoder()
                
                do{
                    let result = try decoder.decode([CryptoModel].self, from: data)
                    
                    return result
                    
                }
                catch{
                    print(error)
                }
            }
            catch{
                print(error)
            }
            
        }
        
        return [CryptoModel]()
    }
}
