//
//  CommunityWriteVO.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 10..
//

import Foundation
struct CommunityWriteVO: Codable {
    let message: String
    let data: CommunityWriteVOData
}

struct CommunityWriteVOData: Codable {
    let imgURL: String
    
    enum CodingKeys: String, CodingKey {
        case imgURL = "img_url"
    }
}
