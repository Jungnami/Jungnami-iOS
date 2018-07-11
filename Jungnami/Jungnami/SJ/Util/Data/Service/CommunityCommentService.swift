//
//  CommunityCommentService.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 11..
//

import Foundation
import Alamofire
import SwiftyJSON

struct CommunityCommentService: GettableService {
    
    typealias NetworkData = CommunityCommentVO
    static let shareInstance = CommunityCommentService()
    func getCommunity(url : String, completion : @escaping (NetworkResult<Any>) -> Void){
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                print("rescode is \(networkResult.resCode)")
                switch networkResult.resCode{
                case 200 : completion(.networkSuccess(networkResult.resResult.data))
                case 403 :
                    completion(.accessDenied)
                case 500 :
                    completion(.serverErr)
                default :
                    print("no 200/403/500")
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
