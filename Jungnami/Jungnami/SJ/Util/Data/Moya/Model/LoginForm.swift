//
//  LoginForm.swift
//  Jungnami
//
//  Created by 강수진 on 26/02/2019.
//

import Foundation

struct LoginForm: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: LoginData?
}

struct LoginData: Codable {
    let token, refreshToken: String
}

