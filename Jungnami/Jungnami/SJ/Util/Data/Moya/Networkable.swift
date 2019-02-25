//
//  Networkable.swift
//  Jungnami
//
//  Created by 강수진 on 21/02/2019.
//

import Moya
import SwiftyJSON

protocol Networkable {
    var provider : MoyaProvider<JungnamiAPI>{ get }
    
    //pms
    func getPartyLegislatorList(isLike : Bool, party: PartyCode, completion: @escaping (MoyaNetworkResult<[CategorizedLegislator]>) -> ())
    func getCityLegislatorList(isLike : Bool, city: CityCode, completion: @escaping (MoyaNetworkResult<[CategorizedLegislator]>) -> ())
    func getAllLegislatorList(isLike : Bool, completion: @escaping (MoyaNetworkResult<LegislatorData>) -> ())
    func getLegislatorDetail(idx : Int, completion: @escaping (MoyaNetworkResult<LegislatorDetail>) -> ())
    func getCommentList(isAboutLegislator :Bool, idx : Int, completion: @escaping (MoyaNetworkResult<[Comment]>) -> ())
    func writeComment(isAboutLegislator : Bool, legiIdx : Int, content : String, completion: @escaping (MoyaNetworkResult<String>) -> ())
    func deleteComment(isAboutLegislator : Bool, commentIdx : Int, writerIdx : Int, completion: @escaping (MoyaNetworkResult<String>) -> ())
    func changeComment(isAboutLegislator : Bool, commentIdx : Int, writerIdx : Int, content : String, completion: @escaping (MoyaNetworkResult<String>) -> ())
    func evaluateComment(isAboutLegislator : Bool, isLike : Bool, commentIdx : Int, completion: @escaping (MoyaNetworkResult<String>) -> ())

    //vote
    func vote(legiCode : Int, isLike : Bool, completion: @escaping (MoyaNetworkResult<String>) -> ())
    func checkBallot(completion: @escaping (MoyaNetworkResult<Int>) -> ())
    
    //cms
    
    //auth
    func refreshToken(refreshToken : String, completion: @escaping (MoyaNetworkResult<String>) -> ())

    
    func fetchData<T: Codable>(api : JungnamiAPI, networkData : T.Type, completion : @escaping (MoyaNetworkResult<(resCode : Int, resResult : T)>)->Void)
}

extension Networkable {
    func fetchData<T: Codable>(api : JungnamiAPI, networkData : T.Type, completion : @escaping (MoyaNetworkResult<(resCode : Int, resResult : T)>)->Void){
        
        provider.request(api) { (result) in
            switch result {
                
            case let .success(res) :
                do {
                    print(JSON(res.data))
                    
                    let resCode = res.statusCode
                    let data = try JSONDecoder().decode(T.self, from: res.data)
                    completion(.Success((resCode, data)))
                } catch let err {
                    print("Decoding Err " + err.localizedDescription)
                }
            case let .failure(err) :
                if let error = err as NSError?, error.code == -1009 {
                    completion(.Failure(.networkConnectFail))
                } else {
                    completion(MoyaNetworkResult.Failure(.networkError(msg: err.localizedDescription)))
                }
            }
        }
    }
}
