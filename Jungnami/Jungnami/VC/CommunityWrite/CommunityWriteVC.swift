//
//  CommunityWriteVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 2..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class CommunityWriteVC: UIViewController, UITextViewDelegate {
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var contentTxtView: UITextView!

    var keyboardDismissGesture: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardSetting()
        profileImgView.makeImageRound()
        self.contentTxtView.delegate = self
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 0 {
            print(textView.text)
            doneBtn.setImage(#imageLiteral(resourceName: "writepage_complete_blue_button"), for: .normal)
            doneBtn.isUserInteractionEnabled = true
        } else {
             doneBtn.setImage(#imageLiteral(resourceName: "writepage_complete_gray_button"), for: .normal)
            doneBtn.isUserInteractionEnabled = false
        }
    }

}

//키보드 대응
extension CommunityWriteVC {
    func setKeyboardSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: true)
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
           
            let keyboardEndframe = self.view.convert(keyboardSize, to : view.window)
            contentTxtView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardEndframe.height, right: 0)
            contentTxtView.scrollIndicatorInsets = contentTxtView.contentInset

            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
            contentTxtView.contentInset = UIEdgeInsets.zero
            self.view.layoutIfNeeded()
    }
    
    func adjustKeyboardDismissGesture(isKeyboardVisible: Bool) {
        if isKeyboardVisible {
            if keyboardDismissGesture == nil {
                keyboardDismissGesture = UITapGestureRecognizer(target: self, action: #selector(tapBackground))
                view.addGestureRecognizer(keyboardDismissGesture!)
            }
        } else {
            if keyboardDismissGesture != nil {
                view.removeGestureRecognizer(keyboardDismissGesture!)
                keyboardDismissGesture = nil
            }
        }
    }
    
    @objc func tapBackground() {
        self.view.endEditing(true)
    }
}

