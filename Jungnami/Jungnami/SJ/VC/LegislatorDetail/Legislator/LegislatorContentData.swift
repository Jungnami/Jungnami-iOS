//
//  LegislatorContentData.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 7..
//

import Foundation

struct LegislatorContentData {
    static var sharedInstance = LegislatorContentData()
    
    var legislatorContents = [LegislatorContentSample]()
    
    init() {
        let legisA = LegislatorContentSample(contentImg: #imageLiteral(resourceName: "dabi"), title: "다비야 여기는 의원디테일화면의 컨텐츠란다다비야 여기는 의원디테일화면의 컨텐츠란다다비야 여기는 의원디테일화면의 컨텐츠란다다비야 여기는 의원디테일화면의 컨텐츠란다", category: "TMI", date: "1111.11.11")
        
        let legisB = LegislatorContentSample(contentImg: #imageLiteral(resourceName: "inni"), title: "여기는 ", category: "스토리", date: "1111.11.11")
        
        let legisC = LegislatorContentSample(contentImg: #imageLiteral(resourceName: "dabi"), title: "다비야 여기는 의원디테일화면의 컨텐츠란다", category: "TMI", date: "1111.11.11")
        
        let legisD = LegislatorContentSample(contentImg: #imageLiteral(resourceName: "inni"), title: "의원디테일화면", category: "TMI", date: "1111.11.11")
        
        let legisE = LegislatorContentSample(contentImg: #imageLiteral(resourceName: "dabi"), title: "다비야 여기는 의원디테일화면의", category: "TMI", date: "1111.11.11")
        
        let legisF = LegislatorContentSample(contentImg: #imageLiteral(resourceName: "inni"), title: "컨텐츠란다", category: "TMI", date: "1111.11.11")
        
        legislatorContents.append(contentsOf: [legisA, legisB, legisC, legisD, legisE, legisF, legisD])
        
    }
}
