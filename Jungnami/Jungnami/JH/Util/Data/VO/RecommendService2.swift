//
//  RecommendService2.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 11..
//

import Foundation
import Alamofire
import SwiftyJSON

//여기
struct RecommendService2 : GettableService {
    // let userDefault = UserDefaults.standard
    typealias NetworkData = RecommendVO //여기
    static let shareInstance = RecommendService2() //여기
    func getRecommendContent(url : String, completion : @escaping (NetworkResult<Any>) -> Void){
        
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.resCode {
                //여기
                case 200 :
                    completion(.networkSuccess(networkResult.resResult.data))
                case 300 :
                    completion(.nullValue)
                case 500 :
                    completion(.serverErr)
                default :
                    break
                    //여기
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


