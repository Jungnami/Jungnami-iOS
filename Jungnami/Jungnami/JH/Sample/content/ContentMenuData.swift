//
//  ContentMenuData.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 6..
//

import Foundation

struct ContentMenuData {
    static var sharedInstance = ContentMenuData()
    
    var contentMenus: [ContentMenuSample] = []
    
    init() {
        let content1 = ContentMenuSample(imgView: #imageLiteral(resourceName: "dabi"), title: "다비야 여기는 추천이야", category: "추천", date: "3분전")
        let content2 = ContentMenuSample(imgView: #imageLiteral(resourceName: "inni"), title: "죽지마 두디나 ㅠ", category: "TMI", date: "어제")
        let content3 = ContentMenuSample(imgView: #imageLiteral(resourceName: "dabi"), title: "나는 배가고파", category: "스토리", date: "지금당장")
        let content4 = ContentMenuSample(imgView: #imageLiteral(resourceName: "inni"), title: "고를수가없어요", category: "추천", date: "어제")
        let content5 = ContentMenuSample(imgView: #imageLiteral(resourceName: "dabi"), title: "안대!", category: "TMI", date: "오늘")
        let content6 = ContentMenuSample(imgView: #imageLiteral(resourceName: "inni"), title: "gidkdk", category: "tmi", date: "1년 전")
        let content7 = ContentMenuSample(imgView: #imageLiteral(resourceName: "dabi"), title: "아아아아", category: "스토리", date: "dkdk")
        contentMenus.append(contentsOf: [content1, content2, content3, content4, content5, content6, content7])
    }
}
