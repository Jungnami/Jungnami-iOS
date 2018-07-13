//
//  LegislatorLikeVO.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 9..
//

import Foundation

struct LegislatorLikeVO: Codable {
    let message: String
    let data: [LegislatorLikeVOData]
}

struct LegislatorLikeVOData: Codable {
    
    let lID: Int
    let lName: String
    let partyName: PartyName
    let position: String
    let scoretext: String
    let profileimg : String?
    let mainimg : String?
    let score : Int
    let ranking: String
    let width: Double
    
    enum CodingKeys: String, CodingKey {
        case lID = "l_id"
        case lName = "l_name"
        case partyName = "party_name"
        case position, scoretext, profileimg, mainimg, ranking, width, score
    }
}

