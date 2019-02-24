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
