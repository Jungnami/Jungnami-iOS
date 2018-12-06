//
//  FollowListVO.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 12..
//

import Foundation

struct FollowListVO: Codable {
    let message: String
    let data: [FollowListVOData]?
}

struct FollowListVOData: Codable {
    let followingID, followingNickname, followingImgURL : String
    var isMyFollowing : String
    
    enum CodingKeys: String, CodingKey {
        case followingID = "following_id"
        case followingNickname = "following_nickname"
        case followingImgURL = "following_img_url"
        case isMyFollowing
    }
}
