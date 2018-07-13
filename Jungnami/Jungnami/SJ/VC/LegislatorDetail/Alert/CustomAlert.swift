//
//  CustomAlert.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 8..
//

import UIKit

class CustomAlert: UIView, Modal {
    
    var backgroundView = UIView() //뒷배경
    var dialogView = UIView() // 띄울 뷰
    
    convenience init(view : UIView, width : CGFloat, height : CGFloat) {
        self.init(frame: UIScreen.main.bounds)
        initialize(view : view, width : width, height : height)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize(view : UIView, width : CGFloat, height : CGFloat){
        
        dialogView.clipsToBounds = true
        
        //뒷배경 설정
        backgroundView.frame = frame
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        addSubview(backgroundView)
        
        
        //팝업 뷰 안에 넣을 커스텀 뷰 설정
        view.frame = dialogView.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dialogView.addSubview(view)
        
        //팝업 뷰
        let dialogViewWidth = width
        let dialogViewHeigth = height
        //dialogView.frame.origin = CGPoint(x: 32, y: frame.height)
        dialogView.frame.size = CGSize(width: dialogViewWidth, height: dialogViewHeigth)
        //dialogView.backgroundColor = UIColor.white
        dialogView.layer.cornerRadius = 6
        addSubview(dialogView)
    }
    
    @objc func didTappedOnBackgroundView(){
        dismiss(animated: false)
    }
    
}
