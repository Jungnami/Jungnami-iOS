//
//  MoyaNetworkResult.swift
//  Jungnami
//
//  Created by 강수진 on 21/02/2019.
//

import Foundation

enum MoyaNetworkResult<T> {
    case Success(T)
    case Failure(Error)
}

enum Error {
    case networkConnectFail
    case networkError(msg : String)
}


enum TokenError : String{
    case jwtExpired = "만료된 토큰입니다."
    case jwtWrongFormat = "잘못된 형식의 토큰입니다."
    case jwtIsNotInHeader = "토큰값이 존재하지 않습니다."
}
