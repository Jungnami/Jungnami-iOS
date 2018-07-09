//
//  GettableService.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 9..
//

import Foundation
import Alamofire
import SwiftyJSON

protocol GettableService {
    associatedtype NetworkData : Codable
    typealias networkResult = (resCode : Int, resResult : NetworkData)
    func get(_ URL:String, completion : @escaping (Result<networkResult>)->Void)
    
}

extension GettableService {
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
    func get(_ URL:String, completion : @escaping (Result<networkResult>)->Void){
        Alamofire.request(URL).responseData {(res) in
            switch res.result {
            case .success :
               
                
                if let value = res.result.value {
                  
                    let decoder = JSONDecoder()
                    do {
                        let resCode = self.gino(res.response?.statusCode)
                        let data = try decoder.decode(NetworkData.self, from: value)
                        
                        let result : networkResult = (resCode, data)
                        completion(.success(result))
                        
                    }catch{
                        completion(.error("에러"))
                    }
                }
                break
            case .failure(let err) :
                completion(.failure(err))
                break
            }
            
        }
    }
}
