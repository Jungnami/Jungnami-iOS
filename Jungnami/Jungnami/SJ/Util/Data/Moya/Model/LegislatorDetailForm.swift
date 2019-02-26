//
//  LegislatorDetailForm.swift
//  Jungnami
//
//  Created by 강수진 on 24/02/2019.
//

import Foundation

struct LegislatorDetailForm: Codable {
    let status: Int
    let message: String
    let success: Bool
    let data: LegislatorDetail?
}


struct LegislatorDetail: Codable {
    let region, phone: String?
    let ordinal: Int?
    let reelection: String?
    let partyCD: PartyCode?
    let blog, twitter, crime, facebook: String?
    let likeRank, dislkeRank: String?
    let legiName: String
    let profileImg: String?
    
    enum CodingKeys: String, CodingKey {
        case region, phone, ordinal, reelection
        case dislkeRank = "dislke_rank"
        case partyCD = "party_cd"
        case blog, twitter, crime, facebook
        case likeRank = "like_rank"
        case legiName = "legi_name"
        case profileImg = "profile_img"
    }
}
