//
//  LoginService.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 9..
//

import Foundation
import Alamofire
import SwiftyJSON


struct LoginService: PostableService {
  
    typealias NetworkData = LoginVO

    static let shareInstance = LoginService()
    func login(url : String, params : [String : Any], completion : @escaping (NetworkResult<Any>) -> Void){
        post(url, params: params) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.resCode{
                case 201 :
                completion(.networkSuccess(networkResult.resResult.data))
                case 401 :
                completion(.accessDenied)
                default :
                    print("login error")
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
