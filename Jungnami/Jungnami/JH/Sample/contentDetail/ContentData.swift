//
//  ContentData.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 5..
//

import Foundation

struct ContentData {
    static var sharedInstance = ContentData()
    
    var contentDetails: [ContentSample] = []
    
    
    let detail1 = ContentSample(images: [#imageLiteral(resourceName: "dabi"),#imageLiteral(resourceName: "inni"),#imageLiteral(resourceName: "dabi"),#imageLiteral(resourceName: "inni")], title: "안녕다뱌 또 보네", date: "2018.09.09", category: "TMI", imageCount: "1/20")
    let detail2 = ContentSample(images: [#imageLiteral(resourceName: "inni"),#imageLiteral(resourceName: "dabi"),#imageLiteral(resourceName: "inni"),#imageLiteral(resourceName: "dabi")], title: "dk", date: "9090.90.90", category: "스토리", imageCount: "1/20")
    let detail3 = ContentSample(images: [#imageLiteral(resourceName: "dabi"),#imageLiteral(resourceName: "inni"),#imageLiteral(resourceName: "dabi"),#imageLiteral(resourceName: "dabi"),#imageLiteral(resourceName: "inni")], title: "아아아아아아아아아아아", date: "2019.09.09", category: "추천", imageCount: "33/20")
    
    init() {
        contentDetails.append(contentsOf: [detail2,detail1])
    }
    
    
}
