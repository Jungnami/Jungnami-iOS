//
//  ChangeCoinVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 9..
//

import UIKit

class ChangeCoinVC: UIViewController, UITextFieldDelegate, APIService {

    
    @IBOutlet weak var scrollView: UIScrollView!
    //투표권 textField
    @IBOutlet weak var voteField: UITextField!
    //나의 보유코인
    @IBOutlet weak var userCoinLbl: UILabel!
    
    var myCoin = 0 {
        didSet {
            userCoinLbl.text = "\(myCoin)개"
        }
    }
    
    
    @IBAction func okBtn(_ sender: Any) {
        
        
    }
    
    var keyboard: UITapGestureRecognizer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMyCoin(url : url("/legislator/support"))
    }
    
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


extension ChangeCoinVC {
    func getMyCoin(url : String){
        GetCoinService.shareInstance.getCoin(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(let coinData):
                let data = coinData as! CoinVOData
                let myCoin = data.userCoin
                self.myCoin = myCoin
                break
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
    }
    
}


