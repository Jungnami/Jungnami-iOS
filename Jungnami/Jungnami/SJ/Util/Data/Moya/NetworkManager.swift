//
//  NetworkManager.swift
//  Jungnami
//
//  Created by 강수진 on 21/02/2019.
//

import Moya

struct NetworkManager : Networkable {
    
    static let sharedInstance = NetworkManager()
    
    static let token = ""
    let provider = MoyaProvider<JungnamiAPI>()
    //(plugins : [NetworkLoggerPlugin(verbose : false)])

}

//pms
extension NetworkManager {
    func getPartyLegislatorList(isLike: Bool, party: PartyCode, completion: @escaping (MoyaNetworkResult<[CategorizedLegislator]>) -> ()) {
        fetchData(api: .legislatorPartyList(isLike: isLike, party: party), networkData: CategorizedLegislatorForm.self) { (result) in
            switch result {
            case .Success(let successResult):
                if successResult.resResult.success {
                    guard let partyLegislatorList = successResult.resResult.data else {return}
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
                    guard let cityLegislatorList = successResult.resResult.data else {return}
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
    
    func getCommentList(isAboutLegislator: Bool, idx: Int, completion: @escaping (MoyaNetworkResult<[Comment]>) -> ()) {
        fetchData(api: .commentList(isAboutLegislator: isAboutLegislator, idx: idx), networkData: CommentForm.self) { (result) in
            switch result {
            case .Success(let successResult):
                if successResult.resResult.success {
                    completion(.Success(successResult.resResult.data))
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
    
    func writeComment(isAboutLegislator: Bool, legiIdx: Int, content: String, completion: @escaping (MoyaNetworkResult<String>) -> ()) {
        fetchData(api: .writeComment(isAboutLegislator: isAboutLegislator, legiIdx: legiIdx, content: content), networkData: NoDataForm.self) { (result) in
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
                    completion(.Success(successResult.resResult.data))
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
                    completion(.Success(successResult.resResult.data))
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

