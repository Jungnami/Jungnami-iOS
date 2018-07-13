//
//  CoinChangePopupView.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 13..
//

import UIKit

class CoinChangePopupView: UIView {

    @IBOutlet weak var changePopupImgView: UIImageView!
     @IBOutlet weak var deleteCoinLbtl: UILabel!
    @IBOutlet weak var myCoinLbtl: UILabel!
    @IBOutlet weak var cancleBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    
    class func instanceFromNib() -> CoinChangePopupView {
        
        return UINib(nibName: "CoinChangePopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CoinChangePopupView
    }

}
