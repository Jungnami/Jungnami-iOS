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
    var data: [CategorizedLegislator]?
}


struct CategorizedLegislator: Codable {
    let region: String
    let ratio : Int?
    let categorizedRank: String?
    let rank: String?
    var voteCnt: Int?
    let legiName: String
    let profileImg: String?
    let idx : Int
    let partyCD : PartyCode?
    let cityCD: CityCode?
    
    enum CodingKeys: String, CodingKey {
        case region, ratio
        case partyCD = "party_cd"
        case categorizedRank = "categorized_rank"
        case rank
        case voteCnt = "vote_cnt"
        case legiName = "legi_name"
        case profileImg = "profile_img"
        case idx
        case cityCD = "city_cd"
    }
}
