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
    let data: [CategorizedLegislator]?
}

struct CategorizedLegislator: Codable {
    let idx: Int
    let legiName : String
    let region: String?
    let partyCD: PartyCode?
    let profileImg: String?
    let likeCnt, dislikeCnt: Int?
    
    enum CodingKeys: String, CodingKey {
        case idx
        case legiName = "legi_name"
        case region
        case partyCD = "party_cd"
        case profileImg = "profile_img"
        case likeCnt = "like_cnt"
        case dislikeCnt = "dislike_cnt"
    }
}
