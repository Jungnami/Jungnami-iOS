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
        return "https://jungnami.ml" + path
    }
    
    func gsno(_ value : String?) -> String{
        return value ?? ""
    }
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
}
