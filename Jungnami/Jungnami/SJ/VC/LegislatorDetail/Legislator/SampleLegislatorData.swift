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
        let a = SampleLegislator(profile: #imageLiteral(resourceName: "dabi"), name: "정다비", likeCount: 12, dislikeCount: 1, region: "서울 성북구 안암동", party: .blue, likeRank: 1, dislikeRank: 1, voteCount: 200000, rate: 0.8)
        let b = SampleLegislator(profile: #imageLiteral(resourceName: "sujin"), name: "강수진", likeCount: 2, dislikeCount: 1, region: "인천", party: .mint, likeRank: 2, dislikeRank: 2, voteCount: 200000, rate: 0.4)
        let c = SampleLegislator(profile: #imageLiteral(resourceName: "dabi"), name: "이지현", likeCount: 12, dislikeCount: 1, region: "대전 대덕구 송촌동", party: .red, likeRank: 3, dislikeRank: 2, voteCount: 200000, rate: 1.0)
        let d = SampleLegislator(profile: #imageLiteral(resourceName: "myungsun"), name: "명선", likeCount: 12, dislikeCount: 1, region: "서울 성북구 안암동", party: .mint, likeRank: 3, dislikeRank: 4, voteCount: 200000, rate: 0.4)
        let e = SampleLegislator(profile: #imageLiteral(resourceName: "jihee"), name: "강지희", likeCount: 12, dislikeCount: 1, region: "서울 성북구 안암동", party: .orange, likeRank: 12, dislikeRank: 4, voteCount: 200000, rate: 0.2)
        let f = SampleLegislator(profile: #imageLiteral(resourceName: "seunghu"), name: "정승후", likeCount: 12, dislikeCount: 1, region: "서울 성북구 안암동", party: .yellow, likeRank: 12, dislikeRank: 4, voteCount: 200000, rate: 0.6)
         let g = SampleLegislator(profile: #imageLiteral(resourceName: "sungchan"), name: "강성찬", likeCount: 12, dislikeCount: 1, region: "서울 성북구 안암동", party: .mint, likeRank: 12, dislikeRank: 4, voteCount: 200000, rate: 0.75)
         let h = SampleLegislator(profile: #imageLiteral(resourceName: "yunhwan"), name: "남윤환", likeCount: 12, dislikeCount: 1, region: "서울 성북구 안암동", party: .blue, likeRank: 12, dislikeRank: 4, voteCount: 200000, rate: 0.84)
         let i = SampleLegislator(profile: #imageLiteral(resourceName: "sunyoung"), name: "이선영", likeCount: 12, dislikeCount: 1, region: "서울 성북구 안암동", party: .blue, likeRank: 12, dislikeRank: 4, voteCount: 200000, rate: 0.1)
         let j = SampleLegislator(profile: #imageLiteral(resourceName: "hyungyun"), name: "최형윤", likeCount: 12, dislikeCount: 1, region: "서울 성북구 안암동", party: .orange, likeRank: 12, dislikeRank: 4, voteCount: 200000, rate: 0.8)
         let k = SampleLegislator(profile: #imageLiteral(resourceName: "suyoung"), name: "임수영", likeCount: 12, dislikeCount: 1, region: "서울 성북구 안암동", party: .red, likeRank: 12, dislikeRank: 4, voteCount: 200000, rate: 1.0)
        let l = SampleLegislator(profile: #imageLiteral(resourceName: "sungmin"), name: "이성민", likeCount: 12, dislikeCount: 1, region: "서울 성북구 안암동", party: .yellow, likeRank: 12, dislikeRank: 4, voteCount: 200000, rate: 0.23)
        let m = SampleLegislator(profile: #imageLiteral(resourceName: "jiyeon"), name: "김지연", likeCount: 12, dislikeCount: 1, region: "서울 성북구 안암동", party: .red, likeRank: 12, dislikeRank: 4, voteCount: 200000, rate: 0.38)
        legislators.append(a)
        legislators.append(b)
        legislators.append(contentsOf: [c,d,e,f,g,h,i,j,k,l,m])
        
    }
}
