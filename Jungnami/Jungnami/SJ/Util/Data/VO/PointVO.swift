//
//  PointVO.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 10..
//

import Foundation


struct PointVO: Codable {
    let message: String
    let data: PointVOData?
}

struct PointVOData: Codable {
    let votingCnt: Int
    
    enum CodingKeys: String, CodingKey {
        case votingCnt = "voting_cnt"
    }
}
