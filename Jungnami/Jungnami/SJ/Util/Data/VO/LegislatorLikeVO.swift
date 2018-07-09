//
//  LegislatorLikeVO.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 9..
//

import Foundation

struct LegislatorLikeVO: Codable {
    let message: String
    let data: [Datum]
}

struct Datum: Codable {
    
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

enum PartyName: String, Codable {
    case 더불어민주당 = "더불어민주당"
    case 자유한국당 = "자유한국당"
    case 민중당 = "민중당"
    case 바른미래당 = "바른미래당"
    case 무소속 = "무소속"
    case 대한애국당 = "대한애국당"
    case 민주평화당 = "민주평화당"
    case 정의당 = "정의당"
}
