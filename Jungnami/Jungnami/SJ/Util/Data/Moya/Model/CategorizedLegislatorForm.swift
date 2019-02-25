//
//  CategorizedLegislatorForm.swift
//  Jungnami
//
//  Created by 강수진 on 21/02/2019.
//

import Foundation

struct CategorizedLegislatorForm: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: CategorizedLegislatorData?
}

struct CategorizedLegislatorData: Codable {
    let timeStamp: String
    let data: [CategorizedLegislator]?
}

struct CategorizedLegislator: Codable {
    let idx: Int
    let legiName: String
    let partyCD : PartyCode?
    let cityCD: CityCode?
    let profileImg: String?
    let voteCnt: Int?
    //고치기 - String "-"
    let rank, partyRank: Int?
    let ratio : Int?
    
    enum CodingKeys: String, CodingKey {
        case idx
        case legiName = "legi_name"
        case partyCD = "party_cd"
        case cityCD = "city_cd"
        case profileImg = "profile_img"
        case voteCnt = "vote_cnt"
        case rank, ratio
        case partyRank = "party_rank"
    }
}
