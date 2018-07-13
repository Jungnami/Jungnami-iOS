//
//  CoinVO.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 10..
//

import Foundation

struct CoinVO: Codable {
    let message: String
    let data: CoinVOData?
}

struct CoinVOData: Codable {
    let userCoin: Int
    
    enum CodingKeys: String, CodingKey {
        case userCoin = "user_coin"
    }
}
