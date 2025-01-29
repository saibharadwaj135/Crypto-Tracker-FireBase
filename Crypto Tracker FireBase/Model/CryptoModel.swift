//
//  CryptoModel.swift
//  Crypto Tracker FireBase
//
//  Created by Sai bharadwaj Adapa on 1/23/25.
//

import Foundation




struct CryptoModel: Codable,Identifiable{
    
    var id : String?
    var name : String?
    var image : String?
    var current_price : Double?
    var market_cap_rank : Int?
    var high_24h : Double?
    var low_24h : Double?
    
}
