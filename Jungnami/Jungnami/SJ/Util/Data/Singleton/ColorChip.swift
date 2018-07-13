//
//  ColorChip.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 5..
//

import UIKit

class ColorChip {
  
    let partyBlue = #colorLiteral(red: 0.07426900417, green: 0.593572855, blue: 0.8904482722, alpha: 1)
    let partyRed = #colorLiteral(red: 0.8823529412, green: 0.1411764706, blue: 0.1019607843, alpha: 1)
    let partyMint = #colorLiteral(red: 0.07843137255, green: 0.8039215686, blue: 0.8, alpha: 1)
    let partyYellow = #colorLiteral(red: 0.9882352941, green: 0.862745098, blue: 0, alpha: 1)
    let partyOrange = #colorLiteral(red: 0.9254901961, green: 0.5490196078, blue: 0.05098039216, alpha: 1)
    let partyNavy = #colorLiteral(red: 0.07058823529, green: 0.1921568627, blue: 0.4039215686, alpha: 1)
    let partyGreen = #colorLiteral(red: 0.2, green: 0.7647058824, blue: 0.1647058824, alpha: 1)
    let partyGray = #colorLiteral(red: 0.7137254902, green: 0.7137254902, blue: 0.7137254902, alpha: 1)
    let mainColor = #colorLiteral(red: 0.2117647059, green: 0.7725490196, blue: 0.9450980392, alpha: 1)
   
    
    
    struct StaticInstance {
        static var instance: ColorChip?
    }
    
    class func shared() -> ColorChip {
        if StaticInstance.instance == nil {
            StaticInstance.instance = ColorChip()
        }
        return StaticInstance.instance!
    }
}
