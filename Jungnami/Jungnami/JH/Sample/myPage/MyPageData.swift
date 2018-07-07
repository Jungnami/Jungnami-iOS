//
//  MyPageData.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 7..
//

import Foundation
struct MyPageData {
    static var sharedInstance = MyPageData()
    
    var myPageUsers = [MyPageSample]()
    
    init() {
        let user1 = MyPageSample(profileImg: #imageLiteral(resourceName: "dabi"), userId: "Dabee", scrapCount: "23", followCount: "22", followerCount: "33", feedCount: "132", coin: "23개", vote: "10개")
        let user2 = MyPageSample(profileImg: #imageLiteral(resourceName: "inni"), userId: "Moon", scrapCount: "1", followCount: "1", followerCount: "1", feedCount: "2", coin: "1개", vote: "22개")
        myPageUsers.append(contentsOf: [user2,user1])
    }
}
