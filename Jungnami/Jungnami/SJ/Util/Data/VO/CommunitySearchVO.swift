//
//  BoardSearchVO.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 11..
//

import Foundation

struct CommunitySearchVO: Codable {
    let data: [CommunitySearchVOData]?
    let message: String
}

struct CommunitySearchVOData: Codable {
    let id: Int
    let nickname, content, imgURL: String
    let userImgURL : String?
    var islike: Int
    let writingtime: String
    var likecnt, commentcnt: Int
    let userId : String
    
    enum CodingKeys: String, CodingKey {
        case id, nickname, content
        case userImgURL = "user_img_url"
        case imgURL = "img_url"
        case islike, writingtime, likecnt, commentcnt
        case userId = "user_id"
    }
}
