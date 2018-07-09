//
//  SupportService.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 10..
//
import Foundation
import Alamofire
import SwiftyJSON


struct SupportService : PostableService {
    
    typealias NetworkData = MessageVO
    
    static let shareInstance = SupportService()
    func support(url : String, params : [String : Any], completion : @escaping (NetworkResult<Any>) -> Void){
        post(url, params: params) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.resCode{
                case 201 :
                    completion(.networkSuccess(""))
                case 401 :
                    completion(.noCoin)
                default :
                    print("vote error")
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
