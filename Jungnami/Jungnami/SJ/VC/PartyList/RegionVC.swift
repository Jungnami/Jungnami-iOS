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
    var selectedRegion : Region?
    
    @IBAction func toNext(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            selectedRegion = .INCHEON
        case 1:
            selectedRegion = .SEOUL
        case 2:
            selectedRegion = .GYUNGGI
        case 3:
            selectedRegion = .GANGWON
        case 4:
            selectedRegion = .CHUNGNAM
        case 5:
            selectedRegion = .CHUNGBUK
        case 6:
            selectedRegion = .DAEJEON
        case 7:
            selectedRegion = .SEJONG
        case 8:
            selectedRegion = .GYUNGBUK
        case 9:
            selectedRegion = .DAEGU
        case 10:
            selectedRegion = .ULSAN
        case 11:
            selectedRegion = .JEONBUK
        case 12:
            selectedRegion = .GWANGJU
        case 13:
            selectedRegion = .JUNNAM
        case 14:
            selectedRegion = .GYUNGNAM
        case 15:
            selectedRegion = .BUSAN
        case 16:
            selectedRegion = .JEJU
            
        default:
            return
        }
        
        print("hihi")
        if let partyListDetailPageMenuVC = self.storyboard?.instantiateViewController(withIdentifier:PartyListDetailPageMenuVC.reuseIdentifier) as? PartyListDetailPageMenuVC {
            partyListDetailPageMenuVC.selectedRegion = selectedRegion
    self.navigationController?.pushViewController(partyListDetailPageMenuVC, animated: true)
        }
    }
    
}

