//
//  LegislatorDetailVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 7..
//

import UIKit


class LegislatorDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, APIService {
    
    @IBOutlet weak var legislatorCollectionView: UICollectionView!
    var selectedLegislatorIdx : Int = 0
    var selectedLegislator : LegislatorDetailVOData?
    var contents : [LegislatorDetailVODataContent]?
    var supportAlert : CustomAlert?
    var completeAlert : CustomAlert?
    var keyboardDismissGesture: UITapGestureRecognizer?
    let supportPopupView = SupportPopupView.instanceFromNib()
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.view.backgroundColor = UIColor.white
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        legislatorDetailInit(url: url("/legislator/page/\(gino(selectedLegislatorIdx))"))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        setKeyboardSetting()
        setupBackBtn()
        legislatorCollectionView.delegate = self
        legislatorCollectionView.dataSource = self
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
}

//백버튼 커스텀과 액션 추가
extension LegislatorDetailVC {
    func setupBackBtn(){
        let backBtn = UIButton(type: .system)
        backBtn.setImage(#imageLiteral(resourceName: "area_left_arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        backBtn.addTarget(self, action:  #selector(self.toBack(_sender:)), for: .touchUpInside)
        backBtn.snp.makeConstraints { (make) in
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
    }
    
    @objc func toBack(_sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

//collectionView datasource, delegate
extension LegislatorDetailVC {
    //--------------collectionView-------------
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return 1
        }else {
            //샘플데이터 넣고 .count넣기!
            if let contents_ = contents {
                return contents_.count
            }
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LegislatorProfileCell.reuseIdentifier, for: indexPath) as! LegislatorProfileCell
            if let selectedLegislator_ = selectedLegislator {
                cell.configure(data: selectedLegislator_)
            }
            
            cell.voteBtn.addTarget(self, action: #selector(support(_sender:)), for: .touchUpInside)
            //  cell.voteBtn.tag = selectedLegislator.고유아이디
            
            cell.likeBtn.addTarget(self, action: #selector(like(_sender:)), for: .touchUpInside)
            cell.dislikeBtn.addTarget(self, action: #selector(dislike(_sender:)), for: .touchUpInside)
            
            
            
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LegislatorRelatedCell.reuseIdentifier, for: indexPath) as! LegislatorRelatedCell
            cell.fixedLbl.text = "관련된 컨텐츠"
            return cell
        } else  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LegislatorContentCell.reuseIdentifier, for: indexPath) as! LegislatorContentCell
            //투두 - 샘플데이터 만들고 configure연결하기
            if let contents_ = contents {
                cell.configure(data: contents_[indexPath.row])
                cell.legislatorContentImgView.layer.cornerRadius = 10
                cell.legislatorContentImgView.layer.masksToBounds = true
            }
            
            
            return cell
        }
        
    }
}

//좋아요, 싫어요, 후원하기에 대한 행동
extension LegislatorDetailVC{
    //좋아요
    @objc func like(_sender: UIButton){
        simpleAlertwithHandler(title: "투표하시겠습니까?", message: "나의 보유 투표권") { (_) in
            self.popupImgView(fileName: "area_like_popup")
        }
    }
    
    //싫어요
    @objc func dislike(_sender: UIButton){
        simpleAlertwithHandler(title: "투표하시겠습니까?", message: "나의 보유 투표권") { (_) in
            self.popupImgView(fileName: "area_hate_popup")
        }
    }
    //후원하기
    @objc func support(_sender: UIButton){
        getMyCoin(url: url("/legislator/support"))
    }

}

//커스텀 모달에 관한 행동 - 후원하기 때 팝업 올라오기, 취소버튼, 확인 (또 다시 모달 올라옴)버튼에 대한 행동, 텍슴트필드 바뀔 때(0 이하일때) 에러 처리
extension LegislatorDetailVC : UITextFieldDelegate{
    
    func showSupportPopup(myCoin : Int){
        supportPopupView.myCoinLbtl.text = "\(myCoin) 코인"
        supportPopupView.inputTxtField.keyboardType = UIKeyboardType.decimalPad
        supportPopupView.inputTxtField.text = ""
        supportPopupView.inputTxtField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        supportPopupView.inputTxtField.delegate = self
        supportPopupView.cancleBtn.addTarget(self, action:#selector(self.cancle(_sender:)), for: .touchUpInside)
        supportPopupView.okBtn.isEnabled = false
        supportPopupView.okBtn.setImage(#imageLiteral(resourceName: "legislator-detailpage_confirm_gray"), for: .normal)
        supportPopupView.okBtn.addTarget(self, action:#selector(self.supportOk(_sender:)), for: .touchUpInside)
        
        supportAlert = CustomAlert(view : supportPopupView, width : 253, height : 297)
        supportAlert?.show(animated: false)
    }
    
    @objc func cancle(_sender: UIButton){
        supportAlert?.dismiss(animated: false)
    }
    
    @objc func supportOk(_sender: UIButton){
        let params : [String : Any] = [
            "l_id" : selectedLegislatorIdx,
            "coin" : gsno(supportPopupView.inputTxtField.text)
        ]
        
        supportOkAction(url: url("/legislator/support"), params: params)
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        supportPopupView.okBtn.isEnabled = false
        supportPopupView.okBtn.setImage(#imageLiteral(resourceName: "legislator-detailpage_confirm_gray"), for: .normal)
        
        if let coin = Int(gsno(textField.text)) {
            if coin > 0 {
                supportPopupView.okBtn.isEnabled = true
                supportPopupView.okBtn.setImage(#imageLiteral(resourceName: "legislator-detailpage_confirm_blue"), for: .normal)
            }
        }
        
    }
    
    func showCompletePopup(){
        let completePopupView = CompletePopupView.instanceFromNib()
        //completePopupView.nameLbl.text = selectedLegislator?.name
        completePopupView.coinLbl.text = "\(gsno(supportPopupView.inputTxtField.text))원"
        completePopupView.okBtn.addTarget(self, action:#selector(self.completeOk(_sender:)), for: .touchUpInside)
        supportAlert?.dismiss(animated: false)
        completeAlert = CustomAlert(view : completePopupView, width : 263, height : 331)
        completeAlert?.show(animated: false)
    }
    
    @objc func completeOk(_sender: UIButton){
        completeAlert?.dismiss(animated: false)
    }
}

//collection View cell 레이아웃
extension LegislatorDetailVC {
    //layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: 375, height: 183)
        }
        if indexPath.section == 1 {
            return CGSize(width: 375, height: 54)
        }else {
            return CGSize(width: 170, height: 187)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 && section == 1 {
            return 0
        }else {
            return 14
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 && section == 1{
            return 0
        }else {
            return 12
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 && section == 1 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else {
            return UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        }
    }
}


//키보드 반응
extension LegislatorDetailVC{
    
    func setKeyboardSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: true)
        
        
        if let firstAlert_ = supportAlert{
            if (0.0) > ((firstAlert_.frame.origin.y)) {
                return
            }
        }
        
        supportAlert?.frame.origin.y -= 50
        
        self.view.layoutIfNeeded()
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
        
        //  firstAlert?.frame.origin.y += 50
        
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

//통신 - 해당 의원 정보 가져오기, 호감/비호감 클릭, 후원하기
extension LegislatorDetailVC {
    //해당 의원 정보 가져오기
    func legislatorDetailInit(url : String){
        GetLegislatorDetailService.shareInstance.getLegislatorDetail(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let legislatorData):
                self.selectedLegislator = legislatorData as? LegislatorDetailVOData
                self.contents = self.selectedLegislator?.contents
                self.legislatorCollectionView.reloadData()
                break
                
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결을 확인해주세요")
            default :
                break
            }
            
        })
        
    }
    //후원하기 클릭
    func getMyCoin(url : String){
        GetCoinService.shareInstance.getCoin(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(let coinData):
                let data = coinData as! CoinVOData
                let myCoin = data.userCoin
                self.showSupportPopup(myCoin: myCoin)
                break
            case .accessDenied :
                self.simpleAlert(title: "오류", message: "로그인을 해주세요")
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
    }
    //후원하기 '확인' 했을때 액션
    func supportOkAction(url : String, params : [String : Any]) {
        SupportService.shareInstance.support(url: url, params : params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(_):
                self.showCompletePopup()
                break
            case .noCoin :
                self.simpleAlert(title: "오류", message: "코인 부족합니다")
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결을 확인해주세요")
            default :
                break
            }
            
        })
    }
    
}
