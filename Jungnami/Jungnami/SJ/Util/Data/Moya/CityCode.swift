//
//  CityCode.swift
//  Jungnami
//
//  Created by 강수진 on 21/02/2019.
//

import Foundation

enum CityCode : Int, Codable{
    case  gangwon = 10001
    case  gyunggi = 10002
    case  gyungnam = 10003
    case  gyungbuk = 10004
    case  gwangju = 10005
    case  daegu = 10006
    case  daejeon = 10007
    case  busan = 10008
    case  birye = 10009
    case  seoul = 10010
    case  sejong = 10011
    case  ulsan = 10012
    case  incheon = 10013
    case  jeonnam = 10014
    case  jeonbuk = 10015
    case  jeju = 10016
    case  chungnam = 10017
    case  chungbuk = 10018

    var cityName : String {
        switch self {
        case .gangwon:
            return "강원"
        case .gyunggi:
            return "경기"
        case .gyungnam:
            return "경남"
        case .gyungbuk:
            return "경북"
        case .gwangju:
            return "광주"
        case .daegu:
            return "대구"
        case .daejeon:
            return "대전"
        case .busan:
            return "부산"
        case .seoul:
            return "서울"
        case .sejong:
            return "세종"
        case .ulsan:
            return "울산"
        case .incheon:
            return "인천"
        case .jeonnam:
            return "전남"
        case .jeonbuk:
            return "전북"
        case .jeju:
            return "제주"
        case .chungnam:
            return "충남"
        case .chungbuk:
            return "충북"
        case .birye:
            return "비례"
        default :
            break
        }
    }
    
    var cityThinImg : UIImage {
        switch self {
        case .gangwon:
            return #imageLiteral(resourceName: "area_gangwon_redbox")
        case .gyunggi:
            return #imageLiteral(resourceName: "area_gyeonggi_skybluebox")
        case .gyungnam:
            return #imageLiteral(resourceName: "area_gyeongnam_redbox")
        case .gyungbuk:
            return #imageLiteral(resourceName: "area_gyeongbuk_redbox")
        case .gwangju:
            return #imageLiteral(resourceName: "area_gwangju_greenbox")
        case .daegu:
            return #imageLiteral(resourceName: "area_daegu_pinkbox")
        case .daejeon:
            return #imageLiteral(resourceName: "area_daejeon_pinkbox")
        case .busan:
            return #imageLiteral(resourceName: "area_busan_redbox")
        case .seoul:
            return #imageLiteral(resourceName: "area_seoul_bluebox")
        case .sejong:
            return #imageLiteral(resourceName: "area_sejong_pinkbox")
        case .ulsan:
            return #imageLiteral(resourceName: "area_ulsan_pinkbox")
        case .incheon:
            return #imageLiteral(resourceName: "area_incheon_skybluebox")
        case .jeonnam:
            return #imageLiteral(resourceName: "area_jeonnam_greenbox")
        case .jeonbuk:
            return #imageLiteral(resourceName: "area_jeonbuk_mintbox")
        case .jeju:
            return #imageLiteral(resourceName: "area_jeju_bluebox")
        case .chungnam:
            return #imageLiteral(resourceName: "area_chungnam_pinkbox")
        case .chungbuk:
            return  #imageLiteral(resourceName: "area_chungbuk_pinkbox")
        case .birye :
            return UIImage()
        default :
            break
        }
    }
}
