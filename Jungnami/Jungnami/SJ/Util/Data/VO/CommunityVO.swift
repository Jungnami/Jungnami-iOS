//
//  CommunityVO.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 10..
//

import Foundation

struct CommunityVO: Codable {
    let message: String
    let data: CommunityVOData
}

struct CommunityVOData: Codable {
    let content: [CommunityVODataContent]
    let alarmcnt: Int
}

struct CommunityVODataContent: Codable {
    let boardid: Int
    let nickname: String
    let userimg : String?
    let img : String
    let writingtime, content: String
    let islike, likecnt, commentcnt: Int
}
