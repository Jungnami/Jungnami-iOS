//
//  NoticeSample.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 9..
//

import Foundation
import UIKit

struct NoticeSample {
    var profileImg: UIImage
    var userNickname: String
    var noticeType: noticeType
    var date: String
}
//    profileImg
//    -> placeholder이미지 남/여 이미지
//    nickname
//    noticeType
//    -> 팔로우, 게시물좋아요,
//    댓글 좋아요,
//    답글(대댓글),내 게시물에 댓글

enum noticeType: String {
    
    case follow
    case contentLike
    case commentLike
    case recomment
    case contentComment
    
    func returnType(userNickName: String) -> String{
        switch self{
        case .follow :
            return "\(userNickName)님이 팔로우합니다."
        case .contentLike:
            return "\(userNickName)님이 회원님의 게시물을 좋아합니다."
        case . commentLike:
            return "\(userNickName)님이 회원님의 댓글을 좋아합니다."
        case .recomment:
            return "\(userNickName)님이 회원님의 댓글에 댓글을 남겼습니다."
        case .contentComment:
            return "\(userNickName)님이 회원님의 게시물에 댓글을 남겼습니다."
        }
        
    }
}

struct NoticeData {
    static var sharedInstance = NoticeData()
    var notices = [NoticeSample]()
    init() {
        let notice1 = NoticeSample(profileImg: #imageLiteral(resourceName: "inni"), userNickname: "이지현", noticeType: .recomment, date: "2시간 전")
        let notice2 = NoticeSample(profileImg: #imageLiteral(resourceName: "dabi"), userNickname: "다비", noticeType: .commentLike, date: "어제")
        
        notices.append(contentsOf: [notice1,notice2])
    }
}
