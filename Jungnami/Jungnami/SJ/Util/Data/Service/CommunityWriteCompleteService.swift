//
//  CommunityWriteCompleteService.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 10..
//

import Foundation
import Alamofire
import SwiftyJSON

struct CommunityWriteCompleteService: PostablewithPhoto {
    
    typealias NetworkData = MessageVO
    static let shareInstance = CommunityWriteCompleteService()
    func registerBoard(url : String, params : [String : Any], image : [String : Data]?, completion : @escaping (NetworkResult<Any>) -> Void){
        
        savePhotoContent(url, params: params, imageData: image) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.resCode {
                case 201 :
                    completion(.networkSuccess(""))
                case 204 :
                    completion(.failInsert)
                case 401 :
                    completion(.accessDenied)
                    
                case 500 :
                    completion(.serverErr)
                default :
                    print("no 201/500 - statusCode is \(networkResult.resCode)")
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
