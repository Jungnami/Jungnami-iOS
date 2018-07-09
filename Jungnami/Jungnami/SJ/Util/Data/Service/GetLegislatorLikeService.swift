//
//  GetLegislatorLikeService.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 9..
//


import Foundation
import Alamofire
import SwiftyJSON

struct GetLegislatorLikeService : GettableService {
   
    
   // let userDefault = UserDefaults.standard
    typealias NetworkData = LegislatorLikeVO
    static let shareInstance = GetLegislatorLikeService()
    
    func getLegislatorLike(url : String, completion : @escaping (NetworkResult<Any>) -> Void){
        
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.resResult.message {
                case "Select Data Success" :
                    completion(.networkSuccess(networkResult.resResult.data))
                case "Internal Server Error" :
                    completion(.serverErr)
                default :
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
