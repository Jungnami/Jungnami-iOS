//
//  ReportService.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 12. 10..
//

import Foundation

struct ReportService: PostableService {
    
    typealias NetworkData = MessageVO
    static let shareInstance = ReportService()
    func report(url : String, params : [String : Any] , completion : @escaping (NetworkResult<Any>) -> Void){
    
        post(url, params: params) { (result) in
            switch result {
            case .success(let networkResult):
                switch networkResult.resCode{
                case 201 :
                    completion(.networkSuccess(""))
                case 401 :
                    completion(.accessDenied)
                case 500 :
                    completion(.serverErr)
                default :
                    print("rescode is \(networkResult.resCode)")
                    break
                }
            case .error(let errMsg) :
                print(errMsg)
                break
            case .failure(_) :
                completion(.networkFail)
            }
        }
        
    }
}
