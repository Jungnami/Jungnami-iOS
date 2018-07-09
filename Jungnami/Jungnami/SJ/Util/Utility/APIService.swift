//
//  APIService.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 9..
//

import Foundation

protocol APIService {}

extension APIService {
    func url(_ path: String) -> String {
        return "http://13.124.216.2:3000" + path
    }
    
    func gsno(_ value : String?) -> String{
        return value ?? ""
    }
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
}
