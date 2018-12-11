//
//  CoinChangeCompletePopupView.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 13..
//

import UIKit

class CoinChangeCompletePopupView: UIView {
    @IBOutlet weak var changeCompletePopupImgView: UIImageView!
    @IBOutlet weak var okBtn: UIButton!
    
    class func instanceFromNib() -> CoinChangeCompletePopupView {
        
        return UINib(nibName: "CoinChangeCompletePopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CoinChangeCompletePopupView
    }

}
