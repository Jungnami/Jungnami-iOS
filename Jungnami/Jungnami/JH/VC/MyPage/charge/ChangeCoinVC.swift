//
//  ChangeCoinVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 9..
//

import UIKit

class ChangeCoinVC: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var scrollView: UIScrollView!
    //투표권 textField
    @IBOutlet weak var voteField: UITextField!
    //나의 보유코인
    @IBOutlet weak var userCoinLbl: UILabel!
    
    var keyboard: UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        voteField.delegate = self
        voteField.keyboardType = .numberPad
         self.hideKeyboardWhenTappedAround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
 
}
//----------------------------keyboard----------------------------------------
extension ChangeCoinVC {
    //keyboardHide
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChangeCoinVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    //keyboardShow && scrollUp
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 250), animated: true)
    }
    //keyboard hide
    func textFieldDidEndEditing(_ textField: UITextField) {
        if voteField == textField {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }
    }
}


