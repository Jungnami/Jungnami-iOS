//
//  PostablewithPhoto.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 9..
//

import Foundation
import Alamofire
import SwiftyJSON

protocol PostablewithPhoto {
    associatedtype NetworkData : Codable
    func savePhotoContent(_ URL:String, params : [String : Any], imageData : [String : Data]?, completion : @escaping (Result<NetworkData>)->Void)
    
    func savePhotowithArray(_ URL:String, params : [String : Any], dicArr: [String : [[String : Any]]], imageData : [String : Data]?, completion : @escaping (Result<NetworkData>)->Void)
}

extension PostablewithPhoto {
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
    //Array<Any>
    func savePhotowithArray(_ URL:String, params : [String : Any], dicArr: [String : [[String : Any]]], imageData : [String : Data]?, completion : @escaping (Result<NetworkData>)->Void){
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            for (x,y) in params {
                if y is String {
                    multipartFormData.append((y as! String).data(using: .utf8)!, withName: x)
                }
                else if y is Int {
                    multipartFormData.append("\(y)".data(using: .utf8)!, withName: x)
                }
            }
            
            for (x,y) in dicArr {
                
                do {
                    
                    let data = try JSONSerialization.data(withJSONObject: y)
                    multipartFormData.append(data as Data , withName: x)
                    print(JSON(data))
                    
                } catch {
                    print("err")
                }
                
                
                
                
                
                
            }
            
            if let images_ = imageData {
                for (x,y) in images_ {
                    multipartFormData.append(y, withName: x, fileName: ".jpeg", mimeType: "image/png")
                    
                }
            }
            
        }, to: URL, method: .post, headers: nil, encodingCompletion:{
            (encodingResult) in
            switch encodingResult {
            case .success(let upload,_,_):
                
                upload.responseData(completionHandler: { (res) in
                    switch res.result{
                    case .success:
                        if let value = res.result.value {
                            let decoder = JSONDecoder()
                            print(JSON(value))
                            do {
                                let data = try decoder.decode(NetworkData.self, from: value)
                                
                                completion(.success(data))
                                
                            }catch{
                                completion(.error("error"))
                            }
                            
                            
                        }
                    case .failure(let err):
                        
                        print(err.localizedDescription)
                        
                        break
                    }
                })
                break
            case .failure(let err):
                
                print(err.localizedDescription)
                break
            }
        })
    }
    
    
    func savePhotoContent(_ URL:String, params : [String : Any], imageData : [String : Data]?, completion : @escaping (Result<NetworkData>)->Void) {
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            for (x,y) in params {
                if y is String {
                    multipartFormData.append((y as! String).data(using: .utf8)!, withName: x)
                }
                else if y is Int {
                    multipartFormData.append("\(y)".data(using: .utf8)!, withName: x)
                }
            }
            
            if let images_ = imageData {
                for (x,y) in images_ {
                    multipartFormData.append(y, withName: x, fileName: ".jpeg", mimeType: "image/png")
                    
                }
            }
            
        }, to: URL, method: .post, headers: nil, encodingCompletion:{
            (encodingResult) in
            switch encodingResult {
            case .success(let upload,_,_):
                upload.responseData(completionHandler: { (res) in
                    
                    switch res.result{
                    case .success:
                        if let value = res.result.value {
                            
                            
                            let decoder = JSONDecoder()
                            do {
                                let data = try decoder.decode(NetworkData.self, from: value)
                                
                                completion(.success(data))
                                
                            }catch{
                                completion(.error("error"))
                            }
                            
                            
                        }
                    case .failure(let err):
                        print(err.localizedDescription)
                        
                        break
                    }
                })
                break
            case .failure(let err):
                print(err.localizedDescription)
                break
            }
        })
    }
}
