//
//  ScrapData.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 5..
//

import Foundation

struct ScrapData{
    static let sharedInstance = ScrapData()
    
    var scraps = [ScrapSample]()
    
    let scrapA = ScrapSample(scrapImgView: #imageLiteral(resourceName: "inni"), scrapTitle: "앱잼끝났으면 좋겠따..ㅎ", scrapCategory: "TMI", scrapDate: "07.14")
    let scrapB = ScrapSample(scrapImgView: #imageLiteral(resourceName: "dabi"), scrapTitle: "다비야 힘내!@!@!@!@!@!@!@!@", scrapCategory: "스토리", scrapDate: "07.02")
    let scrapC = ScrapSample(scrapImgView: #imageLiteral(resourceName: "inni"), scrapTitle: "아 칸이 너무 많아", scrapCategory: "추천", scrapDate: "03.09")
    let scrapD = ScrapSample(scrapImgView: #imageLiteral(resourceName: "dabi"), scrapTitle: "dk", scrapCategory: "TMI", scrapDate: "00.00")
    let scrapE = ScrapSample(scrapImgView: #imageLiteral(resourceName: "inni"), scrapTitle: "ddddddwwwwwwwwwwwwwwwd", scrapCategory: "스토리", scrapDate: "04.12")
    let scrapF = ScrapSample(scrapImgView: #imageLiteral(resourceName: "dabi"), scrapTitle: "didkdkkdkdk", scrapCategory: "TMI", scrapDate: "1889.22.23")
    init() {
        scraps.append(contentsOf: [scrapA,scrapB,scrapC,scrapD,scrapE,scrapF])
    }
}
