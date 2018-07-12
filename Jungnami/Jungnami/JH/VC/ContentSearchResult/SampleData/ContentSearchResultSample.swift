//
//  ContentSearchResultSample.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 13..
//

import Foundation
import UIKit

struct ContentsearchResultSample {
    var img: UIImage
    var title: String
    var info: String
}

struct ContentSearchResultData {
    static let sharedInstance = ContentSearchResultData()
    var searchResultData: [ContentSearchResultData] = []
    
    let data1 = ContentsearchResultSample(img: #imageLiteral(resourceName: "hyungyun"), title: "형윤아 안농", info: "tMI , 2019.11.11")
    let data2 = ContentsearchResultSample(img: #imageLiteral(resourceName: "dongil"), title: "하이동일", info: "스토리. 2019.11.23")
    let data3 = ContentsearchResultSample(img: #imageLiteral(resourceName: "myungsun"), title: "명선 체고체고", info: "tMI , 2019.11.11")
    let data4 = ContentsearchResultSample(img: #imageLiteral(resourceName: "jiyeon"), title: "지연힘내~~!", info: "스토리. 2019.11.23")
    let data5 = ContentsearchResultSample(img: #imageLiteral(resourceName: "yunhwan"), title: "골무모자 짱조아", info: "스토리.2019.11.11")
    let data6 = ContentsearchResultSample(img: #imageLiteral(resourceName: "jiyeon"), title: "지연힘내~~!", info: "스토리. 2019.11.23")
    let data7 = ContentsearchResultSample(img: #imageLiteral(resourceName: "yunhwan"), title: "골무모자 짱조아", info: "스토리.2019.11.11")
    let data8 = ContentsearchResultSample(img: #imageLiteral(resourceName: "jiyeon"), title: "지연힘내~~!", info: "스토리. 2019.11.23")
    let data9 = ContentsearchResultSample(img: #imageLiteral(resourceName: "yunhwan"), title: "골무모자 짱조아", info: "스토리.2019.11.11")
    
    
//    init() {
//        searchResultData.append([data1, data2, data3, data4, data5, data6, data7, data8,data9])
//    }
}
