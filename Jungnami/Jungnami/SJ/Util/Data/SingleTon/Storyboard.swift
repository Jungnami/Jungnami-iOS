//
//  Storyboard.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 8..
//

import UIKit

class Storyboard {
 
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let rankStoryboard = UIStoryboard(name: "Rank", bundle: nil)
    let communityStoryboard = UIStoryboard(name: "Community", bundle: nil)
    
    struct StaticInstance {
        static var instance: Storyboard?
    }
    
    class func shared() -> Storyboard {
        if StaticInstance.instance == nil {
            StaticInstance.instance = Storyboard()
        }
        return StaticInstance.instance!
    }
}
