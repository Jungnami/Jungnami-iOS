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
    case SearchPartyLegislator = "/ranking/search/party/"
    case SearchRegionLegislator = "/ranking/search/city/"
    case SearchLegislator = "/ranking/search/all/"
   
    //커뮤니티
    case Board = "/board/"
    case WriteBoard = "/user/img"
    case LikeBoard = "/board/like/"
    case SearchBoard = "/board/search/"
    case Report = "/user/report/"
    
    //컨텐츠
    case Content = "/contents/"
    case ContentCategory = "/contents/category/"
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
    case LikeBoardComment = "/board/comment/like/"
  
    //팔로우/팔로워
    case User = "/user/"
    case Follow = "/user/follow/"
   
    func getURL(_ parameter : String? = nil) -> String{
        return "http://13.124.216.2:3000\(self.rawValue)\(parameter ?? "")"
    }
}
