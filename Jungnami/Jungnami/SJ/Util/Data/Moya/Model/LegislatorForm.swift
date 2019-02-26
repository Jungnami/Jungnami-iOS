//
//  LegislatorForm.swift
//  Jungnami
//
//  Created by 강수진 on 21/02/2019.
//

import Foundation

struct LegislatorForm: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: LegislatorData?
}

struct LegislatorData: Codable {
    let timeStamp: String
    let data: [Legislator]
}

struct Legislator: Codable {
    let idx: Int
    let legiName: String
    let partyCD: PartyCode?
    let profileImg: String?
    var voteCnt : Int?
    let rank : String?
    let ratio: Double?
    
    enum CodingKeys: String, CodingKey {
        case idx
        case legiName = "legi_name"
        case partyCD = "party_cd"
        case profileImg = "profile_img"
        case voteCnt = "vote_cnt"
        case rank, ratio
    }
}
