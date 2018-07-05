//
//  CommentData.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 3..
//

import Foundation


struct CommentData {
    static let sharedInstance = CommentData()
    
    var comments: [CommentSample] = []
    
    //////////sampleData/////////
    let a = CommentSample(profile: #imageLiteral(resourceName: "dabi"), userId: "daBee", commentContent: "다비야 디팟장해쥬라~!", date: "1시간 전", likeCount: "555", commentCount: "12")
    let b = CommentSample(profile: #imageLiteral(resourceName: "inni"), userId: "dP", commentContent: "12", date: "6시간 전", likeCount: "12", commentCount: "13")
    
    init() {
        comments.append(contentsOf: [a,b])
    }
}

struct RecommentData {
    static let sharedInstance = RecommentData()
    var recomments: [RecommentSample] = []
    
    let c = RecommentSample(profileImg: #imageLiteral(resourceName: "dabi"), userId: "DaBee", recommentContent: "다비야 배고파 ㅠ", date: "지금", likeCount: "777")
    let d = RecommentSample(profileImg: #imageLiteral(resourceName: "dabi"), userId: "Dabee2", recommentContent: "집에 보내주 ㅠㅠ", date: "1분 전", likeCount: "555")
    let e = RecommentSample(profileImg: #imageLiteral(resourceName: "dabi"), userId: "ee", recommentContent: "hi!!!!!!!", date: "어제", likeCount: "44")
    init() {
        recomments.append(contentsOf: [c,d,e])
    }
    
}
