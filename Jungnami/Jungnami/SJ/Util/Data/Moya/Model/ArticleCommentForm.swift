//
//  ArticleCommentForm.swift
//  Jungnami
//
//  Created by 강수진 on 26/02/2019.
//

import Foundation

struct ArticleCommentForm: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [ArticleComment]?
}

struct ArticleComment: Codable {
    let idx, articleID, writer: Int
    let content, writetime: String
    let parent, depth, likeCnt, dislikeCnt: Int
    let rereply: [ArticleComment]?
    
    enum CodingKeys: String, CodingKey {
        case idx
        case articleID = "article_id"
        case writer, content, writetime, parent, depth
        case likeCnt = "like_cnt"
        case dislikeCnt = "dislike_cnt"
        case rereply
    }
}
