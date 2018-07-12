//
//  TapDelegate.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 8..
//

import Foundation

protocol TapDelegate {
    func myTableDelegate(index : Int)
    
}

protocol DoubleTapDelegate {
     func myDoubleTapDelegate(sender : UITapGestureRecognizer)
}

protocol TapDelegate2 {
    func myTableDelegate(sender : UITapGestureRecognizer)
}
