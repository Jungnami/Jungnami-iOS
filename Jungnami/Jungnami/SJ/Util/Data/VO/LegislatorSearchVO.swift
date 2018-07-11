//
//  LegislatorSearchVO.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 11..
//

import Foundation

struct LegislatorSearchVO: Codable {
    let data: [LegislatorSearchVOData]?
    let message: String
}

struct LegislatorSearchVOData: Codable {
    let id: Int
    let name, position, imgurl: String
    let party : PartyName
    let rank: String
    let voted : Bool
}
