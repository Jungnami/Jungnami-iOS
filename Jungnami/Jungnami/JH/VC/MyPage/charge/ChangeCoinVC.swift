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
    var buyCount = 0
    let coinChangePopupView = CoinChangePopupView.instanceFromNib()
    var supportAlert : CustomAlert?
    var completeAlert : CustomAlert?
    
    @IBOutlet weak var okBtn1: UIButton!
    @IBAction func okBtn(_ sender: Any) {
        
        
        
        showSupportPopup(myCoin: voteField.text!)
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
        okBtn1.isEnabled = false
        okBtn1.setTitleColor(.lightGray, for: .normal)
        voteField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
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
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if gsno(textField.text) == "" {
            okBtn1.isEnabled = false
            okBtn1.setTitleColor(.lightGray, for: .normal)
            return
        }
       
        if let coin = Int(gsno(textField.text)) {
            if coin > 0 && coin <= myCoin {
               buyCount = coin
                okBtn1.isEnabled = true
                okBtn1.setTitleColor(ColorChip.shared().mainColor, for: .normal)
             
            } else {
                
                okBtn1.isEnabled = false
                okBtn1.setTitleColor(.lightGray, for: .normal)
               
            }
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


//커스텀 모달에 관한 행동 - 후원하기 때 팝업 올라오기, 취소버튼, 확인 (또 다시 모달 올라옴)버튼에 대한 행동, 텍슴트필드 바뀔 때(0 이하일때) 에러 처리
extension ChangeCoinVC {
    
    func showSupportPopup(myCoin : String){
        coinChangePopupView.myCoinLbtl.text = myCoin
        coinChangePopupView.deleteCoinLbtl.text = "-\(myCoin)"
        
        coinChangePopupView.cancleBtn.addTarget(self, action:#selector(self.cancle(_sender:)), for: .touchUpInside)
        coinChangePopupView.okBtn.addTarget(self, action:#selector(self.supportOk(_sender:)), for: .touchUpInside)
        
        supportAlert = CustomAlert(view : coinChangePopupView, width : 255, height : 300)
        supportAlert?.show(animated: false)
    }
    
    @objc func cancle(_sender: UIButton){
        supportAlert?.dismiss(animated: false)
    }
    
    @objc func supportOk(_sender: UIButton){
        let params : [String : Any] = [
            "coin" : buyCount
        ]
        
         supportOkAction(url: url("/user/addvote"), params: params)
    }
    
    
    func showCompletePopup(){
        let completePopupView = CoinChangeCompletePopupView.instanceFromNib()
        completePopupView.okBtn.addTarget(self, action:#selector(self.completeOk(_sender:)), for: .touchUpInside)
        supportAlert?.dismiss(animated: false)
        completeAlert = CustomAlert(view : completePopupView, width : 257, height : 312)
        completeAlert?.show(animated: false)
    }
    
    @objc func completeOk(_sender: UIButton){
        completeAlert?.dismiss(animated: false)
        self.dismiss(animated: true, completion: nil)
    }
}


extension ChangeCoinVC {
    //후원하기 '확인' 했을때 액션
    func supportOkAction(url : String, params : [String : Any]) {
        SupportService.shareInstance.support(url: url, params : params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(_):
                self.showCompletePopup()
                break
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결을 확인해주세요")
            default :
                break
            }
            
        })
    }
}

