//
//  JungnamiAPI.swift
//  Jungnami
//
//  Created by 강수진 on 21/02/2019.
//

import Foundation
import Moya

enum JungnamiAPI  {
    case legislatorCityList(isLike : Bool, city : CityCode)
    case legislatorPartyList(isLike : Bool, party : PartyCode)
    case legislatorList(isLike : Bool)
    case legislatorDetail(idx : Int)
    case vote(legiCode : Int, isLike : Bool)
    case checkBallot
    
    case commentList(isAboutLegislator : Bool, idx : Int)
    case writeComment(isAboutLegislator : Bool, legiIdx : Int, content : String)
    case deleteComment(isAboutLegislator : Bool, commentIdx : Int, writerIdx : Int)
    case changeComment(isAboutLegislator : Bool, commentIdx : Int, writerIdx : Int, content : String)
    //    case reportComment(isAboutLegislator : Bool, commentIdx : Int)
    case evaluateComment(isAboutLegislator : Bool, isLike : Bool, commentIdx : Int)
    
    case refreshToken(refreshToken : String)
    
}

enum JungnamiAPIType  {
    case vote
    case cms
    case pms
    case auth
}

extension JungnamiAPI : TargetType{
    var apiType : JungnamiAPIType {
        switch self {
        case .legislatorCityList, .legislatorPartyList, .legislatorDetail:
            return .pms
        case .legislatorList, .vote, .checkBallot :
            return .vote
        case .commentList(let isAboutLegislator,_):
            return isAboutLegislator ? .pms : .cms
        case .writeComment(let isAboutLegislator, _, _) :
            return isAboutLegislator ? .pms : .cms
        case .deleteComment(let isAboutLegislator, _, _):
            return isAboutLegislator ? .pms : .cms
        case .changeComment(let isAboutLegislator, _, _, _):
            return isAboutLegislator ? .pms : .cms
        case .refreshToken:
            return .auth
        case .evaluateComment(let isAboutLegislator,_,_):
             return isAboutLegislator ? .pms : .cms
        }
    }
    
    var baseURL: URL {
        func getUrl(portNum : Int) -> URL{
            guard let url = URL(string: "http://localhost:\(portNum)") else { fatalError("base url could not be configured")}
            return url
        }
        switch self.apiType {
        case .vote:
            return getUrl(portNum: 3400)
        case .cms:
            return getUrl(portNum: 3300)
        case .pms:
            return getUrl(portNum: 3200)
        case .auth:
            return getUrl(portNum: 3100)
        }
    }
    
    var path: String {
        switch self {
        case .legislatorCityList(let isLike, let city):
            let like = isLike ? 1: 0
            return "/ranking/city/\(city.rawValue)/\(like)"
        case .legislatorPartyList(let isLike, let party):
            let like = isLike ? 1: 0
            return "/ranking/party/\(party.rawValue)/\(like)"
        case .legislatorList(let isLike):
            let like = isLike ? 1: 0
            return "/vote/result/\(like)"
        case .vote:
            return "/vote"
        case .checkBallot :
            return "/vote/ballot/check"
        case .legislatorDetail(let idx):
            return "/legislator/\(idx)"
        case .commentList(let isAboutLegislator, let idx):
            //고치기 - 뒤에 cms 일때
            return isAboutLegislator ? "/reply/\(idx)" : ""
        case .writeComment(let isAboutLegislator, _, _):
            //고치기 - 뒤에 cms 일때
            return isAboutLegislator ? "/reply" : ""
        case .deleteComment(let isAboutLegislator, _, _):
            //고치기 - 뒤에 cms 일때
            return isAboutLegislator ? "/reply" : ""
        case .changeComment(let isAboutLegislator, _, _, _):
            //고치기 - 뒤에 cms 일때
            return isAboutLegislator ? "/reply" : ""
        case .refreshToken(_):
            return "/auth/refresh"
        case .evaluateComment(let isAboutLegislator, let isLike, let commentIdx):
             //고치기 - 뒤에 cms 일때
            let like = isLike ? 1: 0
            return isAboutLegislator ? "/like/\(like)/\(commentIdx)" : ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .legislatorCityList, .legislatorPartyList, .legislatorList, .legislatorDetail:
            return .get
        case .vote:
            return .post
        case .checkBallot :
            return .get
        case .commentList :
            return .get
        case .writeComment :
            return .post
        case .deleteComment:
            return .delete
        case .changeComment:
            return .put
        case .refreshToken:
            return .post
        case .evaluateComment :
            return .post
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .legislatorCityList, .legislatorPartyList, .legislatorList, .checkBallot, .legislatorDetail:
            return .requestPlain
        case .vote(let legiCode, let isLike):
            let parameters : [String : Any] = ["code" : legiCode,
                                               "isLike" : isLike]
            //고치기 - body 인지 query 인지
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .commentList, .evaluateComment :
            return .requestPlain
        case .deleteComment(let isAboutLegislator, let commentIdx, let writerIdx):
            //고치기 - 뒤에 cms 일때
            let parameters : [String : Any] = isAboutLegislator ? ["reply_idx" : commentIdx,
                                                                   "writer" : writerIdx] : [:]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
       
        case .writeComment(let isAboutLegislator, let legiIdx, let content):
            //고치기 - 뒤에 cms 일때
            let parameters : [String : Any] = isAboutLegislator ? ["legi_id" : legiIdx,
                                                                   "content" : content] : [:]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .changeComment(let isAboutLegislator, let commentIdx, let writerIdx, let content):
            //고치기 - 뒤에 cms 일때
            let parameters : [String : Any] = isAboutLegislator ? ["reply_idx" : commentIdx,
                                                                   "writer" : writerIdx,
                                                                   "content" : content] : [:]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .refreshToken(let refreshToken):
            let parameters : [String : Any] = ["refreshToken" : refreshToken]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    var validationType : ValidationType {
        return .successAndRedirectCodes
    }
    
    var headers: [String : String]? {
        return ["Content-type" : "application/json",
                "token" : NetworkManager.token]
    }
}


