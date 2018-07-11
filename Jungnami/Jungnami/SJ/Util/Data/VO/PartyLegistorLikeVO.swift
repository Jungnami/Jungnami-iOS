//
//  RegionLegistorLikeVO.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 9..
//

import Foundation
struct PartyLegistorLikeVO: Codable {
    let data: [PartyLegistorLikeVOData]
    let message: String

}

struct PartyLegistorLikeVOData: Codable {
    let id: Int
    let name, position: String
    let imgurl: String?
    let rank : Int
    let rankInAll: String
    let partyName: PartyName
    
    enum CodingKeys: String, CodingKey {
        case partyName = "party_name"
        case id, name, imgurl, rank, rankInAll, position
    }
}

