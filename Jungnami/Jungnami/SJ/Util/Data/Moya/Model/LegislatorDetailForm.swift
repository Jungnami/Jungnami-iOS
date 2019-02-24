//
//  LegislatorDetailForm.swift
//  Jungnami
//
//  Created by 강수진 on 24/02/2019.
//

import Foundation

struct LegislatorDetailForm: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: LegislatorDetail?
}

struct LegislatorDetail: Codable {
    let legiName: String
    let partyCD: PartyCode?
    let region: String?
    let ordinal: Int?
    let profileImg: String?
    let reelection: String?
    let crime, twitter, facebook, blog: String?
    let phone: String?
    
    //고치기
    let likerank : String = "1"
    let unlikerank : String = "1"
    
    enum CodingKeys: String, CodingKey {
        case legiName = "legi_name"
        case partyCD = "party_cd"
        case region, ordinal
        case profileImg = "profile_img"
        case reelection, crime, twitter, facebook, blog, phone
        case likerank, unlikerank
    }
}
