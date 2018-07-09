//
//  LoginVO.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 9..
//

import Foundation

struct LoginVO: Codable {
    let data: LoginVOData
    let message: String
}

struct LoginVOData: Codable {
    let token: String
    let id : Int
}
