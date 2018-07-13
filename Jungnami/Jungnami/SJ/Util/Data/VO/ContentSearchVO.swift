//
//  ContentSearchVO.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 13..
//

import Foundation


struct ContentSearchVO: Codable {
    let data: [ContentSearchVOData]?
    let message: String
}

struct ContentSearchVOData: Codable {
    let contentsid: Int
    let title: String
    let thumbnail: String?
    let text: String
}
