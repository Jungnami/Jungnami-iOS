//
//  ReportButton.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 12. 11..
//

import UIKit

class ReportButton : UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setBtnClickEvent()
    }
    var delegate : ReportDelegate?
    var selectedIdx : Int = 0
    func setBtnClickEvent() {
        self.addTarget(self, action: #selector(ReportButton.touchBtn(_:)), for: UIControlEvents.touchUpInside)
    }
    
    @objc func touchBtn(_ sender : ReportButton){
        delegate?.report(index: selectedIdx)
    }
}
