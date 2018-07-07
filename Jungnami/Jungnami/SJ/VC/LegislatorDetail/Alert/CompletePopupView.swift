//
//  CompletePopupView.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 8..
//

import UIKit

class CompletePopupView : UIView {
    
    @IBOutlet weak var completePopupImg: UIImageView!
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var coinLbl : UILabel!
    @IBOutlet weak var okBtn: UIButton!
    class func instanceFromNib() -> CompletePopupView {
        
        return UINib(nibName: "CompletePopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CompletePopupView
    }
}
