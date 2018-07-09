//
//  PostableService.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 9..
//

import Foundation
import Alamofire
import SwiftyJSON


protocol PostableService {
    associatedtype NetworkData : Codable
    typealias networkResult = (resCode : Int, resResult : NetworkData)
    func post(_ URL:String, params : [String : Any], completion : @escaping (Result<networkResult>)->Void)
    
    func delete(_ URL:String, params : [String : Any], completion : @escaping (Result<networkResult>)->Void)
}

extension PostableService {
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
    
    func post(_ URL:String, params : [String : Any], completion : @escaping (Result<networkResult>)->Void){
        
        guard let encodedUrl = URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("networking - invalid url")
            return
        }
        
        let userToken = UserDefaults.standard.string(forKey: "userToken") ?? "-1"
    
        var headers: HTTPHeaders?
        if userToken != "-1" {
            headers = [
            "authorization" : userToken
            ]
        }
      

        Alamofire.request(encodedUrl, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseData(){
            res in
            switch res.result {
            case .success:
                print("networkPostHere")
                print(JSON(res.result))
                if let value = res.result.value {
                    print(JSON(value))
                    let decoder = JSONDecoder()
                    
                    
                    do {
                        
                        let resCode = self.gino(res.response?.statusCode)
                        let data = try decoder.decode(NetworkData.self, from: value)
                        
                        let result : networkResult = (resCode, data)
                        completion(.success(result))
    
                        
                    }catch{
                        
                        completion(.error("error post"))
                    }
                }
                break
            case .failure(let err):
                completion(.failure(err))
                break
            }
        }
        
        
    }
    
    
    func delete(_ URL:String, params : [String : Any], completion : @escaping (Result<networkResult>)->Void){
        
        Alamofire.request(URL, method: .delete, parameters: params, encoding: JSONEncoding.default, headers: nil).responseData(){
            res in
            switch res.result {
            case .success:
                
                if let value = res.result.value {
                    
                    let decoder = JSONDecoder()
                    
                    do {
                        let resCode = self.gino(res.response?.statusCode)
                        let data = try decoder.decode(NetworkData.self, from: value)
                        
                        let result : networkResult = (resCode, data)
                        completion(.success(result))
                        
                        
                    }catch{
                        
                        completion(.error("error"))
                    }
                }
                break
            case .failure(let err):
                completion(.failure(err))
                break
            }
        }
        
        
    }
}

