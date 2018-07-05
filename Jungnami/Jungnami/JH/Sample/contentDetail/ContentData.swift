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
    
    
    let detail1 = ContentSample(imgaes: [#imageLiteral(resourceName: "dabi"),#imageLiteral(resourceName: "inni"),#imageLiteral(resourceName: "dabi"),#imageLiteral(resourceName: "inni")], title: "안녕다뱌 또 보네", date: "2018.09.09", category: "TMI", imageCount: "1")
    let detail2 = ContentSample(imgaes: [#imageLiteral(resourceName: "inni"),#imageLiteral(resourceName: "dabi"),#imageLiteral(resourceName: "inni"),#imageLiteral(resourceName: "dabi")], title: "dk", date: "9090.90.90", category: "스토리", imageCount: "2")
    
    init() {
        contentDetails.append(contentsOf: [detail2,detail1])
    }
    
    
}
