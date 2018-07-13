//
//  ContentSearchService.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 13..
//

import Foundation

struct ContentSearchService: GettableService {
    
    typealias NetworkData = ContentSearchVO
    static let shareInstance = ContentSearchService()
    func searchContent(url : String, completion : @escaping (NetworkResult<Any>) -> Void){
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
                    print("no 200/300/500 rescode is \(networkResult.resCode)")
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
