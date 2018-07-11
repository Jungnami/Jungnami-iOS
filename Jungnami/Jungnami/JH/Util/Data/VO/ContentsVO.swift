//
//  ContentsVO.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 11..
//

import Foundation

struct RecommendVO: Codable {
    let message: String
    let data: RecommendVOData?
}

struct RecommendVOData: Codable {
    let content: [RecommendVODataContent]
    let alarmcnt: Int
}

struct RecommendVODataContent: Codable {
    let contentsid: Int
    let title: String
    let thumbnail: String?
    let text: String
    let type: Int
}

