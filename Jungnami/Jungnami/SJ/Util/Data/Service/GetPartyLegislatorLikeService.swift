//
//  GetRegionLegislatorLikeService.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 9..
//


import Foundation
import Alamofire
import SwiftyJSON

struct GetPartyLegislatorLikeService : GettableService {
    
    typealias NetworkData = PartyLegistorLikeVO
    static let shareInstance = GetPartyLegislatorLikeService()
    
    func getLegislatorLike(url : String, completion : @escaping (NetworkResult<Any>) -> Void){
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.resCode{
                case 200 : completion(.networkSuccess(networkResult.resResult.data))
                case 500 :
                    completion(.serverErr)
                default :
                    print("neither 200 nor 500")
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
