//
//  AlarmVO.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 12..
//
import Foundation

struct AlarmVO: Codable {
    let message: String
    let data: [AlarmVOData]
}

struct AlarmVOData: Codable {
    var button : String
    let id, imgURL, actionname: String
    let actionmessage, time: String
    let ischecked: Int
    
    enum CodingKeys: String, CodingKey {
        case button, id
        case imgURL = "img_url"
        case actionname, actionmessage, time, ischecked
    }
}
