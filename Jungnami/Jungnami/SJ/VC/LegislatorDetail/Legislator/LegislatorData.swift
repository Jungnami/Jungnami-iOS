//
//  LegislatorData.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 7..
//

import Foundation

struct LegislatorData{
    static var sharedInstance = LegislatorData()
    
    var legislators = [LegislatorSample]()
    
    init() {
        let legis1 = LegislatorSample(profileImg: #imageLiteral(resourceName: "dabi"), name: "정다비", party: "정나미디자인짱당", region: "인천여우재로", likeRank: "호감1위", dislikeRank: "비호감0위")
        let legis2 = LegislatorSample(profileImg: #imageLiteral(resourceName: "inni"), name: "문", party: "ㅇㅇ", region: "33", likeRank: "ㄸ", dislikeRank: "3434")
        legislators.append(contentsOf: [legis1, legis2])
    }
}
