//
//  HttpResponseCode.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 9..
//

import Foundation


enum HttpResponseCode: Int{
    case GET_SUCCESS = 200
    case POST_SUCCESS = 201
    case OTHER_ERROR = 401
    case SERVER_ERROR = 500
}

enum ErrorMessage : String {
    case NO_DATA = "No data" //200
    case ACCESS_DENIED = "Access Denied" //401
    case NO_COIN = "No coin" //401
    case NO_VOTE = "No vote" //401
    case SERVER_ERROR = "Internal Server Error" //500
}


enum Result<T> {
    case success(T)
    case error(String)
    case failure(Error)
}

enum NetworkResult<T> {
    case networkSuccess(T)
    case nullValue
    case duplicated
    case serverErr
    case networkFail
    case wrongInput
    case accessDenied
    case noCoin
    case noPoint
    case failInsert
}


