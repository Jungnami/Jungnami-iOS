//
//  MypageService.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 12..
//

import Foundation

import Foundation

struct MypageService : GettableService {
    // let userDefault = UserDefaults.standard
    typealias NetworkData = MyPageVO //여기
    static let shareInstance = MypageService() //여기
    func getUserPage(url : String, completion : @escaping (NetworkResult<Any>) -> Void){
        
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.resCode {
                //여기
                case 200 :
                    completion(.networkSuccess(networkResult.resResult.data))
                case 500 :
                    completion(.serverErr)
             
                default :
                    print("no 200/500/ resCode is \(networkResult.resCode)")
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
