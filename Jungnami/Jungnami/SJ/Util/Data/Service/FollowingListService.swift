//
//  FollowListService.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 12..
//

import Foundation

struct FollowingListService : GettableService {
    typealias NetworkData = FollowListVO //여기
    static let shareInstance = FollowingListService() //여기
    func getFollowingList(url : String, completion : @escaping (NetworkResult<Any>) -> Void){
        
        get(url) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.resCode {
                //여기
                case 200 :
                    if networkResult.resResult.message == "No data" {
                        completion(.nullValue)
                    } else {
                      completion(.networkSuccess(networkResult.resResult.data))
                    }
                case 401 :
                    completion(.accessDenied)
                case 500 :
                    completion(.serverErr)
                default :
                    print("no 200/300/500 resCode is \(networkResult.resCode)")
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
