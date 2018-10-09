//
//  UrlPath.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 8. 9..
//

import Foundation

enum UrlPath : String {
    //로그인
    case KakaoLogin = "/user/login/kakao"
    
    //국회의원
    case LegislatorList = "/ranking/all/"
    case GetPointToVote = "/user/vote"
    case VoteLegislator = "/legislator/vote"
    case LegislatorDetail = "/legislator/page/"
    case GetCoin = "/user/point"
    case SupportLegislator = "/legislator/support"
    case PartyLegislatorList = "/ranking/party/"
    case RegionLegislatorList = "/ranking/city/"
    case SearchLegislator = "/ranking/all/search/"
   
    //커뮤니티
    case Board = "/board/"
    case WriteBoard = "/user/img"
    case LikeBoard = "/board/like/"
    case SearchBoard = "/board/search/"
    
    //컨텐츠
    case Content = "/contents/"
    case ContentDetail = "/contents/detail/"
    case SearchContent = "/contents/search/"
    case LikeContent = "/contents/like/"
    case ScrapContent = "/user/scrap/"
    
    //마이페이지
    case Mypage = "/user/mypage/"
    case AlarmList = "/user/push"
    
    case ChangeCoin = "/user/addvote"
    
    //댓글
    case BoardCommentList = "/board/comment/"
    case ContentCommentList = "/contents/comment/"
    case WriteContentComment = "/contents/comment"
    case LikeContentComment = "/contents/comment/like/"
    
    case DeleteBoardComment = "/delete/boardcomment/"
    case LikeBoardComment = "/board/likecomment"
    case DislikeBoardCommnet = "/delete/boardcommentlike/"
    
    //팔로우/팔로워
    case User = "/user/"
    case Follow = "/user/follow"
   
    func getURL(_ parameter : String? = nil) -> String{
        return "https://jungnami.tk\(self.rawValue)\(parameter ?? "")"
    }
}
