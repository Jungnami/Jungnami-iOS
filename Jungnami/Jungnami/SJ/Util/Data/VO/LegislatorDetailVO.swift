//
//  LegislatorDetailVO.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 9..
//
import Foundation

struct LegislatorDetailVO: Codable {
    let message: String
    let data: LegislatorDetailVOData
}

struct LegislatorDetailVOData: Codable {
    let lID: Int
    let lName, position : String
    let partyName : PartyName
    let profileimg: String?
    let likerank : String
    let unlikerank : String
    let contents: [LegislatorDetailVODataContent]
    
    enum CodingKeys: String, CodingKey {
        case lID = "l_id"
        case lName = "l_name"
        case partyName = "party_name"
        case position, profileimg, contents, likerank, unlikerank
    }
}

//category, writingtime
struct LegislatorDetailVODataContent: Codable {
    let id: Int
    let title, text : String
    let thumbnailURL : String?
    enum CodingKeys: String, CodingKey {
        case id = "c_id"
        case thumbnailURL = "thumbnail"
        case title = "c_title"
        case text
    }
}
