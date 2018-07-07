//
//  SampleLegislatorData.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 8..
//

import Foundation


struct SampleLegislatorData {
    static var sharedInstance = SampleLegislatorData()
    
    var legislators = [SampleLegislator]()
    
    init() {
        let a = SampleLegislator(profile: #imageLiteral(resourceName: "dabi"), name: "정다비", likeCount: 12, dislikeCount: 1, region: "서울 성북구 안암동", party: .blue, likeRank: 12, dislikeRank: 4, voteCount: 200000, rate: 0.8)
        let b = SampleLegislator(profile: #imageLiteral(resourceName: "inni"), name: "강수진", likeCount: 12, dislikeCount: 1, region: "인천", party: .mint, likeRank: 12, dislikeRank: 4, voteCount: 200000, rate: 0.4)
        let c = SampleLegislator(profile: #imageLiteral(resourceName: "dabi"), name: "이지현", likeCount: 12, dislikeCount: 1, region: "대전 대덕구 송촌동", party: .red, likeRank: 12, dislikeRank: 4, voteCount: 200000, rate: 1.0)
        let d = SampleLegislator(profile: #imageLiteral(resourceName: "dabi"), name: "명선", likeCount: 12, dislikeCount: 1, region: "서울 성북구 안암동", party: .mint, likeRank: 12, dislikeRank: 4, voteCount: 200000, rate: 1.8)
        let e = SampleLegislator(profile: #imageLiteral(resourceName: "dabi"), name: "강지희", likeCount: 12, dislikeCount: 1, region: "서울 성북구 안암동", party: .orange, likeRank: 12, dislikeRank: 4, voteCount: 200000, rate: 1.8)
        let f = SampleLegislator(profile: #imageLiteral(resourceName: "dabi"), name: "정승후", likeCount: 12, dislikeCount: 1, region: "서울 성북구 안암동", party: .yellow, likeRank: 12, dislikeRank: 4, voteCount: 200000, rate: 1.8)
        legislators.append(a)
        legislators.append(b)
        legislators.append(contentsOf: [c,d,e,f])
        
    }
}
