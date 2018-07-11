//
//  CommunityService.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 10..
//

import Foundation
import Alamofire
import SwiftyJSON

struct CommunityService: GettableService {
    
    typealias NetworkData = CommunityVO
    static let shareInstance = CommunityService()
    func getCommunity(url : String, completion : @escaping (NetworkResult<Any>) -> Void){
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.resCode{
                case 200 : completion(.networkSuccess(networkResult.resResult.data))
                case 300 :
                    completion(.nullValue)
                case 500 :
                    completion(.serverErr)
                default :
                    print("no 200/300/500")
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
