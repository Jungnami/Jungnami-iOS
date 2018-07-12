//
//  FollowerListVO.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 12..
//

import Foundation

struct FollowerListVO: Codable {
    let message: String
    let data: [FollowerListVOData]?
}

struct FollowerListVOData: Codable {
    let followerID, followerNickname, followerImgURL, isMyFollowing: String
    
    enum CodingKeys: String, CodingKey {
        case followerID = "follower_id"
        case followerNickname = "follower_nickname"
        case followerImgURL = "follower_img_url"
        case isMyFollowing
    }
}
