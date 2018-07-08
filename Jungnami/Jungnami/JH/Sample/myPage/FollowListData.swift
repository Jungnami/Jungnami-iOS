//
//  FollowListData.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 8..
//

import Foundation

struct FollowListData {
    static var sharedInstance = FollowListData()
    
    var followers = [FollowListSample]()
    
    init() {
        let follow1 = FollowListSample(user: "강수진", nickName: "sujinNalJin", profileImg: #imageLiteral(resourceName: "inni"), follower: true, follow: false)
        let follow2 = FollowListSample(user: "정다비", nickName: "daBee", profileImg: #imageLiteral(resourceName: "dabi"), follower: false, follow: true)
        let follow3 = FollowListSample(user: "이지현", nickName: "감댜같은 지혀니", profileImg: #imageLiteral(resourceName: "inni"), follower: true, follow: true)
        let follow4 = FollowListSample(user: "최형윤", nickName: "돌돌문어", profileImg: #imageLiteral(resourceName: "dabi"), follower: false, follow: false)
        let follow5 = FollowListSample(user: "명선", nickName: "혼밥말고떼밥하자", profileImg: #imageLiteral(resourceName: "inni"), follower: false, follow: true)
        
        followers.append(contentsOf: [follow1, follow2, follow3, follow4, follow5])
    }
}
