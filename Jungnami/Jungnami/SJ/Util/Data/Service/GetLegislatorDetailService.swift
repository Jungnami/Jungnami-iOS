//
//  GetLegislatorDetailService.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 9..
//

import Foundation
import Alamofire
import SwiftyJSON

struct GetLegislatorDetailService : GettableService {
    
    typealias NetworkData = LegislatorDetailVO
    static let shareInstance = GetLegislatorDetailService()
    
    func getLegislatorDetail(url : String, completion : @escaping (NetworkResult<Any>) -> Void){
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
