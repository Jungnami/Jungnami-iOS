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
    
    
    /*
     profileImg
     -> placeholder이미지 남/여 이미지
     nickname
     noticeType
     -> 팔로우, 게시물좋아요,
     댓글 좋아요,
     답글(대댓글),내 게시물에 댓글
     
     var profileImg: UIImage
     var nickName: string
     var noticeType: string
     
     
     

 */
}

enum noticeType: String {
    case follow
    case contentLike
    case commentLike
    case recomment
    case contentComment
}
