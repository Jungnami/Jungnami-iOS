//
//  UrlPath.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 8. 9..
//

import Foundation

enum UrlPath : String {
    case SearchLegislator = "/search/legislator/"
    case KakaoLogin = "/user/kakaologin"
    case LegislatorLikeList = "/ranking/list/1"
    case LegislatorDislikeList = "/ranking/list/0"
    case VoteLegislator = "/legislator/voting"
    
    func getURL(_ parameter : String? = nil) -> String{
        return "https://jungnami.ml\(self.rawValue)\(parameter ?? "")"
    }
}
