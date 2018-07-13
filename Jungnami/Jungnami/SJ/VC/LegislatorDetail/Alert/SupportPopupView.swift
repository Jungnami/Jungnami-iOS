//
//  SupportPopupView.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 8..
//

import UIKit

class SupportPopupView : UIView {
    
    @IBOutlet weak var supportPopupImg: UIImageView!
    @IBOutlet weak var myCoinLbtl: UILabel!
    @IBOutlet weak var inputTxtField: UITextField!
    @IBOutlet weak var cancleBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    class func instanceFromNib() -> SupportPopupView {
        
        return UINib(nibName: "SupportPopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SupportPopupView
    }
}
