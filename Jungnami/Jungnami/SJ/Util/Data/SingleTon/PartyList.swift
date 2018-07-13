//
//  PartyList.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 5..
//

import Foundation
enum PartyList : String {
    case blue = "더불어민주당"
    case red = "자유한국당"
    case mint = "바른미래당"
    case yellow = "정의당"
    case orange = "민중당"
}


enum PartyName: String, Codable {
    case 더불어민주당 = "더불어민주당"
    case 자유한국당 = "자유한국당"
    case 민중당 = "민중당"
    case 바른미래당 = "바른미래당"
    case 무소속 = "무소속"
    case 대한애국당 = "대한애국당"
    case 민주평화당 = "민주평화당"
    case 정의당 = "정의당"
}
