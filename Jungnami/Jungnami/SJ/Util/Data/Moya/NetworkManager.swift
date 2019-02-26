//
//  NetworkManager.swift
//  Jungnami
//
//  Created by 강수진 on 21/02/2019.
//

import Moya

struct NetworkManager : Networkable {
    static let sharedInstance = NetworkManager()

    static private var token = ""
    static private var refreshToken = ""
    let provider = MoyaProvider<JungnamiAPI>()
    //(plugins : [NetworkLoggerPlugin(verbose : false)])
    
    static func setToken(_ newToken : String){
        NetworkManager.token = newToken
    }
    
    static func getToken() -> String{
        return NetworkManager.token
    }
    
    static func setRefreshToken(_ newToken : String){
        NetworkManager.refreshToken = newToken
    }
    
    static func getRefreshToken() -> String{
        return NetworkManager.refreshToken
    }
}

//pms
extension NetworkManager {
    /*func errorCompletionHandler<T>(errorType : Error, completion: @escaping (MoyaNetworkResult<T>) -> ()){
        switch errorType {
        case .networkConnectFail:
            completion(.Failure(.networkConnectFail))
        case .networkError(let msg):
            completion(.Failure(.networkError(msg: msg)))
        }
    }

    //고치기
    func getPartyLegislatorList(isLike: Bool, party: PartyCode, completion: @escaping (MoyaNetworkResult<[CategorizedLegislator]>) -> ()) {
        fetchData(api: .legislatorPartyList(isLike: isLike, party: party), networkData: CategorizedLegislatorForm.self) { (result) in
            switch result {
            case .Success(let successResult):
                if successResult.resResult.success {
                    guard let partyLegislatorList = successResult.resResult.data?.data else {return}
                    completion(.Success(partyLegislatorList))
                } else {
                    completion(.Failure(.networkError(msg: successResult.resResult.message)))
                }
            case .Failure(let errorType) :
                self.errorCompletionHandler(errorType: errorType, completion: completion)
            }
        }
    }*/
 
    func getPartyLegislatorList(isLike: Bool, party: PartyCode, completion: @escaping (MoyaNetworkResult<[CategorizedLegislator]>) -> ()) {
        fetchData(api: .legislatorPartyList(isLike: isLike, party: party), networkData: CategorizedLegislatorForm.self) { (result) in
            switch result {
            case .Success(let successResult):
                if successResult.resResult.success {
                    guard let partyLegislatorList = successResult.resResult.data?.data else {return}
                    completion(.Success(partyLegislatorList))
                } else {
                    completion(.Failure(.networkError(msg: successResult.resResult.message)))
                }
            case .Failure(let errorType) :
                switch errorType {
                case .networkConnectFail:
                    completion(.Failure(.networkConnectFail))
                case .networkError(let msg):
                    completion(.Failure(.networkError(msg: msg)))
                }
            }
        }
    }
    
    func getCityLegislatorList(isLike: Bool, city: CityCode, completion: @escaping (MoyaNetworkResult<[CategorizedLegislator]>) -> ()) {
        fetchData(api: .legislatorCityList(isLike: isLike, city: city), networkData: CategorizedLegislatorForm.self) { (result) in
            switch result {
            case .Success(let successResult):
                if successResult.resResult.success {
                    guard let cityLegislatorList = successResult.resResult.data?.data else {return}
                    completion(.Success(cityLegislatorList))
                } else {
                    completion(.Failure(.networkError(msg: successResult.resResult.message)))
                }
            case .Failure(let errorType) :
                switch errorType {
                case .networkConnectFail:
                    completion(.Failure(.networkConnectFail))
                case .networkError(let msg):
                    completion(.Failure(.networkError(msg: msg)))
                }
            }
        }
    }
    
    func getLegislatorDetail(idx: Int, completion: @escaping (MoyaNetworkResult<LegislatorDetail>) -> ()) {
        fetchData(api: .legislatorDetail(idx: idx), networkData: LegislatorDetailForm.self) { (result) in
            switch result {
            case .Success(let successResult):
                if successResult.resResult.success {
                    guard let legislatorDetail = successResult.resResult.data else {return}
                    completion(.Success(legislatorDetail))
                } else {
                    completion(.Failure(.networkError(msg: successResult.resResult.message)))
                }
            case .Failure(let errorType) :
                switch errorType {
                case .networkConnectFail:
                    completion(.Failure(.networkConnectFail))
                case .networkError(let msg):
                    completion(.Failure(.networkError(msg: msg)))
                }
            }
        }
    }
    
    func getLegiCommentList(idx: Int, completion: @escaping (MoyaNetworkResult<[LegiComment]>) -> ()) {
        fetchData(api: .legiCommentList(idx: idx), networkData: LegiCommentForm.self) { (result) in
            switch result {
            case .Success(let successResult):
                if successResult.resResult.success {
                    guard let commentList = successResult.resResult.data else {return}
                    completion(.Success(commentList))
                } else {
                    completion(.Failure(.networkError(msg: successResult.resResult.message)))
                }
            case .Failure(let errorType) :
                switch errorType {
                case .networkConnectFail:
                    completion(.Failure(.networkConnectFail))
                case .networkError(let msg):
                    completion(.Failure(.networkError(msg: msg)))
                }
            }
        }
    }
    
    func getArticleCommentList(idx: Int, completion: @escaping (MoyaNetworkResult<[ArticleComment]>) -> ()) {
        fetchData(api: .articleCommentList(idx: idx), networkData: ArticleCommentForm.self) { (result) in
            switch result {
            case .Success(let successResult):
                if successResult.resResult.success {
                    guard let commentList = successResult.resResult.data else {return}
                    completion(.Success(commentList))
                } else {
                    completion(.Failure(.networkError(msg: successResult.resResult.message)))
                }
            case .Failure(let errorType) :
                switch errorType {
                case .networkConnectFail:
                    completion(.Failure(.networkConnectFail))
                case .networkError(let msg):
                    completion(.Failure(.networkError(msg: msg)))
                }
            }
        }
    }
    
    func writeComment(isAboutLegislator: Bool, relatedIdx: Int, parentCommentIdx : Int = 0, content: String, completion: @escaping (MoyaNetworkResult<String>) -> ()) {
        fetchData(api: .writeComment(isAboutLegislator: isAboutLegislator, relatedIdx: relatedIdx, parentCommentIdx: parentCommentIdx, content: content), networkData: NoDataForm.self) { (result) in
            switch result {
            case .Success(let successResult):
                if successResult.resResult.success {
                    completion(.Success(successResult.resResult.message))
                } else {
                    completion(.Failure(.networkError(msg: successResult.resResult.message)))
                }
            case .Failure(let errorType) :
                switch errorType {
                case .networkConnectFail:
                    completion(.Failure(.networkConnectFail))
                case .networkError(let msg):
                    completion(.Failure(.networkError(msg: msg)))
                }
            }
        }
    }
    
    func deleteComment(isAboutLegislator: Bool, commentIdx: Int, writerIdx : Int, completion: @escaping (MoyaNetworkResult<String>) -> ()) {
        fetchData(api: .deleteComment(isAboutLegislator: isAboutLegislator, commentIdx: commentIdx, writerIdx: writerIdx), networkData: NoDataForm.self) { (result) in
            switch result {
            case .Success(let successResult):
                if successResult.resResult.success {
                    completion(.Success(successResult.resResult.message))
                } else {
                    completion(.Failure(.networkError(msg: successResult.resResult.message)))
                }
            case .Failure(let errorType) :
                switch errorType {
                case .networkConnectFail:
                    completion(.Failure(.networkConnectFail))
                case .networkError(let msg):
                    completion(.Failure(.networkError(msg: msg)))
                }
            }
        }
    }
    
    func changeComment(isAboutLegislator: Bool, commentIdx: Int, writerIdx: Int, content: String, completion: @escaping (MoyaNetworkResult<String>) -> ()) {
        fetchData(api: .changeComment(isAboutLegislator: isAboutLegislator, commentIdx: commentIdx, writerIdx: writerIdx, content: content), networkData: NoDataForm.self) { (result) in
            switch result {
            case .Success(let successResult):
                if successResult.resResult.success {
                    completion(.Success(successResult.resResult.message))
                } else {
                    completion(.Failure(.networkError(msg: successResult.resResult.message)))
                }
            case .Failure(let errorType) :
                switch errorType {
                case .networkConnectFail:
                    completion(.Failure(.networkConnectFail))
                case .networkError(let msg):
                    completion(.Failure(.networkError(msg: msg)))
                }
            }
        }
    }
    
    func evaluateComment(isAboutLegislator: Bool, isLike: Bool, commentIdx: Int, completion: @escaping (MoyaNetworkResult<String>) -> ()) {
        fetchData(api: .evaluateComment(isAboutLegislator: isAboutLegislator, isLike: isLike, commentIdx: commentIdx), networkData: NoDataForm.self) { (result) in
            switch result {
            case .Success(let successResult):
                if successResult.resResult.success {
                    completion(.Success(successResult.resResult.message))
                } else {
                    completion(.Failure(.networkError(msg: successResult.resResult.message)))
                }
            case .Failure(let errorType) :
                switch errorType {
                case .networkConnectFail:
                    completion(.Failure(.networkConnectFail))
                case .networkError(let msg):
                    completion(.Failure(.networkError(msg: msg)))
                }
            }
        }
    }
    
    func reportComment(isAboutLegislator: Bool, commentIdx: Int, reason: String, completion: @escaping (MoyaNetworkResult<String>) -> ()) {
        fetchData(api: .reportComment(isAboutLegislator: isAboutLegislator, commentIdx: commentIdx, reason : reason), networkData: NoDataForm.self) { (result) in
            switch result {
            case .Success(let successResult):
                if successResult.resResult.success {
                    completion(.Success(successResult.resResult.message))
                } else {
                    completion(.Failure(.networkError(msg: successResult.resResult.message)))
                }
            case .Failure(let errorType) :
                switch errorType {
                case .networkConnectFail:
                    completion(.Failure(.networkConnectFail))
                case .networkError(let msg):
                    completion(.Failure(.networkError(msg: msg)))
                }
            }
        }
    }
}

//vote
extension NetworkManager {
    func getAllLegislatorList(isLike: Bool, completion: @escaping (MoyaNetworkResult<LegislatorData>) -> ()) {
        fetchData(api: .legislatorList(isLike : isLike), networkData: LegislatorForm.self) { (result) in
            switch result {
            case .Success(let successResult):
                if successResult.resResult.success {
                    guard let legislatorList = successResult.resResult.data else {return}
                    completion(.Success(legislatorList))
                } else {
                    completion(.Failure(.networkError(msg: successResult.resResult.message)))
                }
            case .Failure(let errorType) :
                switch errorType {
                case .networkConnectFail:
                    completion(.Failure(.networkConnectFail))
                case .networkError(let msg):
                    completion(.Failure(.networkError(msg: msg)))
                }
            }
        }
    }
    
    func vote(legiCode: Int, isLike: Bool, completion: @escaping (MoyaNetworkResult<String>) -> ()) {
        fetchData(api: .vote(legiCode: legiCode, isLike: isLike), networkData: NoDataForm.self) { (result) in
            switch result {
            case .Success(let successResult):
                if successResult.resResult.success {
                    completion(.Success(successResult.resResult.message))
                } else {
                    completion(.Failure(.networkError(msg: successResult.resResult.message)))
                }
            case .Failure(let errorType) :
                switch errorType {
                case .networkConnectFail:
                    completion(.Failure(.networkConnectFail))
                case .networkError(let msg):
                    completion(.Failure(.networkError(msg: msg)))
                }
            }
        }
    }
    
    func checkBallot(completion: @escaping (MoyaNetworkResult<Int>) -> ()) {
        fetchData(api: .checkBallot, networkData: Ballot.self) { (result) in
            switch result {
            case .Success(let successResult):
                if successResult.resResult.success {
                    guard let voteCount = successResult.resResult.data else {return}
                    completion(.Success(voteCount))
                } else {
                    completion(.Failure(.networkError(msg: successResult.resResult.message)))
                }
            case .Failure(let errorType) :
                switch errorType {
                case .networkConnectFail:
                    completion(.Failure(.networkConnectFail))
                case .networkError(let msg):
                    completion(.Failure(.networkError(msg: msg)))
                }
            }
        }
    }
}

//auth
extension NetworkManager {
    func refreshToken(refreshToken: String, completion: @escaping (MoyaNetworkResult<String>) -> ()) {
        fetchData(api: .refreshToken(refreshToken: refreshToken), networkData: StringDataForm.self) { (result) in
            switch result {
            case .Success(let successResult):
                if successResult.resResult.success {
                    guard let newToken = successResult.resResult.data else {return}
                    completion(.Success(newToken))
                } else {
                    completion(.Failure(.networkError(msg: successResult.resResult.message)))
                }
                
            case .Failure(let errorType) :
                switch errorType {
                case .networkConnectFail:
                    completion(.Failure(.networkConnectFail))
                case .networkError(let msg):
                    completion(.Failure(.networkError(msg: msg)))
                }
            }
        }
    }
    
    func kakaoLogin(fcmToken: String, accessToken: String, completion: @escaping (MoyaNetworkResult<LoginData>) -> ()) {
        fetchData(api: .kakaoLogin(fcmToken: fcmToken, accessToken: accessToken), networkData: LoginForm.self) { (result) in
            switch result {
            case .Success(let successResult):
                if successResult.resResult.success {
                    guard let loginData = successResult.resResult.data else {return}
                    completion(.Success(loginData))
                } else {
                    completion(.Failure(.networkError(msg: successResult.resResult.message)))
                }
                
            case .Failure(let errorType) :
                switch errorType {
                case .networkConnectFail:
                    completion(.Failure(.networkConnectFail))
                case .networkError(let msg):
                    completion(.Failure(.networkError(msg: msg)))
                }
            }
        }
    }
}
