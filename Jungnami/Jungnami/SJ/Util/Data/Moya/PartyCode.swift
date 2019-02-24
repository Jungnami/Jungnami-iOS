//
//  PartyCode.swift
//  Jungnami
//
//  Created by 강수진 on 21/02/2019.
//

import Foundation

enum PartyCode : Int, Codable{
    case  none = 101030
    case  jungeui = 101180
    case  dubuleo = 101182
    case  jahan = 101186
    case  daehan = 101188
    case  minjung = 101190
    case  minpyung = 101191
    case  bami = 101192
    
    var partyColor : UIColor {
        switch self {
        case .none:
            return #colorLiteral(red: 0.7137254902, green: 0.7137254902, blue: 0.7137254902, alpha: 1)
        case .jungeui:
            return #colorLiteral(red: 0.9882352941, green: 0.862745098, blue: 0, alpha: 1)
        case .dubuleo:
            return #colorLiteral(red: 0.07426900417, green: 0.593572855, blue: 0.8904482722, alpha: 1)
        case .jahan:
            return #colorLiteral(red: 0.8823529412, green: 0.1411764706, blue: 0.1019607843, alpha: 1)
        case .daehan:
            return #colorLiteral(red: 0.07058823529, green: 0.1921568627, blue: 0.4039215686, alpha: 1)
        case .minjung:
            return #colorLiteral(red: 0.9254901961, green: 0.5490196078, blue: 0.05098039216, alpha: 1)
        case .minpyung:
            return #colorLiteral(red: 0.2, green: 0.7647058824, blue: 0.1647058824, alpha: 1)
        case .bami:
            return #colorLiteral(red: 0.07843137255, green: 0.8039215686, blue: 0.8, alpha: 1)
        default:
            break
        }
    }
    var partyName : String {
        switch self {
        case .none:
            return "무소속"
        case .jungeui:
            return "정의당"
        case .dubuleo:
            return "더불어민주당"
        case .jahan:
            return "자유한국당"
        case .daehan:
            return "대한애국당"
        case .minjung:
            return "민중당"
        case .minpyung:
            return "민주평화당"
        case .bami:
            return "바른미래당"
        default:
            break
        }
    }
    
    var partyThinImg : UIImage {
        switch self {
        case .none:
            return #imageLiteral(resourceName: "partylist_thin_graybox")
        case .jungeui:
            return #imageLiteral(resourceName: "partylist_thin_yellowbox")
        case .dubuleo:
            return  #imageLiteral(resourceName: "partylist_thin_bluebox")
        case .jahan:
            return #imageLiteral(resourceName: "partylist_thin_redbox")
        case .daehan:
            return #imageLiteral(resourceName: "partylist_thin_navybox")
        case .minjung:
            return #imageLiteral(resourceName: "partylist_thin_orangebox")
        case .minpyung:
            return #imageLiteral(resourceName: "partylist_thin_greenbox")
        case .bami:
            return #imageLiteral(resourceName: "partylist_thin_mint")
        }
    }
}

