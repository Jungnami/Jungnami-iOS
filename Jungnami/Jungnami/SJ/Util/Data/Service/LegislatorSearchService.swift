//
//  RankLegislatorSearchService.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 11..
//

import Foundation

struct LegislatorSearchService: GettableService {
    
    typealias NetworkData = LegislatorSearchVO
    static let shareInstance = LegislatorSearchService()
    func searchLegislator(url : String, completion : @escaping (NetworkResult<Any>) -> Void){
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.resCode{
                case HttpResponseCode.GET_SUCCESS.rawValue :
                    if networkResult.resResult.message == ResponseMessage.SUCCESS.rawValue {
                        completion(.networkSuccess(networkResult.resResult.data))
                    } else {
                        completion(.nullValue)
                    }
                    
                case HttpResponseCode.SERVER_ERROR.rawValue :
                    completion(.serverErr)
                default :
                    print("no 200/300/500 rescode is \(networkResult.resCode)")
                    break
                }
                break
            case .error(let errMsg) :
                print(errMsg)
                break
            case .failure(_) :
                completion(.networkFail)
            }
        }
        
    }
}
