//
//  CommentForm.swift
//  Jungnami
//
//  Created by 강수진 on 24/02/2019.
//

import Foundation

struct LegiCommentForm: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: [LegiComment]?
}

struct LegiComment: Codable {
    let idx, legiIdx, writer: Int
    let content, writetime: String
    
    enum CodingKeys: String, CodingKey {
        case idx
        case legiIdx = "legi_idx"
        case writer, content, writetime
    }
}
