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
    case SearchLegislator = "/search/legislator/"
    case LegislatorList = "/ranking/all/"
    case VoteLegislator = "/legislator/voting"
    case SearchPartyLegislator = "/search/legislatorparty/"
    case SearchRegionLegislator = "/search/legislatorregion/"
    case PartyLegislatorLikeList = "/legislatorlist/groupbyparty/1/"
    case PartyLegislatorDislikeList = "/legislatorlist/groupbyparty/0/"
    case RegionLegislatorLikeList = "/legislatorlist/groupbyregion/1/"
    case RegionLegislatorDislikeList = "/legislatorlist/groupbyregion/0/"
    case LegislatorDetail = "/legislator/page/"
    case SupportLegislator = "/legislator/support"
    //커뮤니티
    case WriteComplete = "/board/postcomplete"
    case LikeBoard = "/board/likeboard"
    case DislikeBoard = "/delete/boardlike/"
    case SearchBoard = "/search/board/"
    case BoardList = "/board/boardlist"
    case WriteBoard = "/board/post"
    //컨텐츠
    case SearchContent = "/search/contents/"
    case RecommendContent = "/contents/recommend"
    case TMIContent = "/contents/main/TMI"
    case StoryContent = "/contents/main/스토리"
    case ContentDetail = "/contents/cardnews/"
    case LikeContent = "/contents/like"
    case DislikeContent = "/delete/contentslike/"
    case ScrapContent = "/contents/scrap"
    case UnScrapContent = "/delete/scrap/"
    //마이페이지
    case Mypage = "/user/mypage/"
    case ChangeCoin = "/user/addvote"
    case AlarmList = "/user/push"
    //댓글
    case BoardCommentList = "/board/commentlist/"
    case WriteBoardComment = "/board/makecomment"
    
    case LikeBoardComment = "/board/likecomment"
    case DislikeBoardCommnet = "/delete/boardcommentlike/"
    case ContentCommentList = "/contents/commentlist/"
    case WriteContentComment = "/contents/makecomment"
    case DeleteContentComment = "/delete/contentscomment/"
    case LikeContentComment = "/contents/likecomment"
    case DislikeContentCommnet = "/delete/contentscommentlike/"
    //팔로우/팔로워
    case FollowerList = "/user/followerlist/"
    case FollowingList = "/user/followinglist/"
    case Follow = "/user/follow"
    case UnFollow = "/user/unfollow/"
    case SearchFollower = "/search/follower/"
    case SearchFollowing = "/search/following/"
    

    case DeleteBoardComment = "/delete/boardcomment/"
    
   
    
    func getURL(_ parameter : String? = nil) -> String{
        return "https://jungnami.ml\(self.rawValue)\(parameter ?? "")"
    }
}
