//
//  RegionVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 3..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class RegionVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    /*
     0 : 인천
     1 : 서울
     2 : 경기
     3 : 강원
     4 : 충남
     5 : 충북
     6 : 대전
     7 : 세종
     8 : 경북
     9 : 대구
     10 : 울산
     11 : 전북
     12 : 광주
     13 : 전남
     14 : 경남
     15 : 부산
     16 : 제주
     */
    var selectedRegion : CityCode?
    
    @IBAction func toNext(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            selectedRegion = .incheon
        case 1:
            selectedRegion = .seoul
        case 2:
            selectedRegion = .gyunggi
        case 3:
            selectedRegion = .gangwon
        case 4:
            selectedRegion = .chungnam
        case 5:
            selectedRegion = .chungbuk
        case 6:
            selectedRegion = .daejeon
        case 7:
            selectedRegion = .sejong
        case 8:
            selectedRegion = .gyungbuk
        case 9:
            selectedRegion = .daegu
        case 10:
            selectedRegion = .ulsan
        case 11:
            selectedRegion = .jeonbuk
        case 12:
            selectedRegion = .gwangju
        case 13:
            selectedRegion = .jeonnam
        case 14:
            selectedRegion = .gyungnam
        case 15:
            selectedRegion = .busan
        case 16:
            selectedRegion = .jeju
            
        default:
            return
        }
        

        if let partyListDetailPageMenuVC = self.storyboard?.instantiateViewController(withIdentifier:PartyListDetailPageMenuVC.reuseIdentifier) as? PartyListDetailPageMenuVC {
            partyListDetailPageMenuVC.selectedRegion = selectedRegion
              partyListDetailPageMenuVC.navTitle = "지역"
        self.navigationController?.pushViewController(partyListDetailPageMenuVC, animated: true)
        }
    }
    
}

