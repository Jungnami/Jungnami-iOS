//
//  CommunityTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 1..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class CommunityVC: UIViewController, UISearchBarDelegate {
    
    
    @IBOutlet weak var badgeImg: UIImageView!
    @IBOutlet weak var alarmLbl: UILabel!
    @IBOutlet weak var searchTxtfield: UITextField!
    @IBOutlet weak var separateView: UIView!
    @IBOutlet weak var communityTableView: UITableView!
   
    
    lazy var blackView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.4
        return view
    }()
    
    
    
    var keyboardDismissGesture: UITapGestureRecognizer?
    var login : Bool = false {
        didSet {
           communityTableView.reloadData()
        }
    }
    

    
    
    @IBAction func mypageBtn(_ sender: Any) {
        
    }
    
    @IBAction func alarmBtn(_ sender: Any) {
    }
    
    
    var sampleData : [Sample] = []
    
    override func viewWillAppear(_ animated: Bool) {
        searchTxtfield.text = ""
        let userIdx = UserDefaults.standard.string(forKey: "userToken") ?? "-1"
        print("community VC Check")
        print(userIdx)
        //유저가 로그인 되어있는지 아닌지 체크
        if userIdx == "-1" {
            login = false
        } else {
            login = true
        }
    }
    ////////SampleData//////
    let badgeCount = 0
    //////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTxtfield.delegate = self
        communityTableView.dataSource = self
        communityTableView.delegate = self
        setKeyboardSetting()
        alarmLbl.sizeToFit()
        searchTxtfield.enablesReturnKeyAutomatically = false
        self.navigationController?.isNavigationBarHidden = true
        self.communityTableView.addSubview(blackView)
        blackView.isHidden = true
        blackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(separateView.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            alarmLbl.adjustsFontSizeToFitWidth = true
            if(badgeCount > 99){
                badgeImg.isHidden = false
                alarmLbl.text = "99+"
            } else if badgeCount == 0 {
                badgeImg.isHidden = true
            } else {
                badgeImg.isHidden = false
                alarmLbl.text = "\(badgeCount)"
            }
            
        }
        
        //refreshControl
        self.communityTableView.refreshControl = UIRefreshControl()
        self.communityTableView.refreshControl?.addTarget(self, action: #selector(startReloadTableView(_:)), for: .valueChanged)
        
        //////////////////////뷰 보기 위한 샘플 데이터//////////////////////////
        
        let a = Sample(profileUrl: #imageLiteral(resourceName: "dabi"), name: "다비다비", time: "1시간 전", content: "다비 최고야,, 형윤 최고야,, 디자인 세상에서 제일 예뻐요 선생님들,, ", like: 3, comment: 5, contentImg: nil, heart: true, scrap: false)
        let b = Sample(profileUrl: #imageLiteral(resourceName: "mypage_profile_girl"), name: "제리", time: "4시간 전", content: "픽미픽미픽미업", like: 73, comment: 6020, contentImg: #imageLiteral(resourceName: "inni"), heart: false, scrap: true)
        
        sampleData.append(a)
        sampleData.append(b)
        ////////////////////////////////////////////////////
        
        
    }
    
}

//tableView deleagete, datasource
extension CommunityVC : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return sampleData.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            if !login {
                let cell = tableView.dequeueReusableCell(withIdentifier: CommunityFirstSectionLoginTVCell.reuseIdentifier) as! CommunityFirstSectionLoginTVCell
                cell.nextBtn.addTarget(self, action: #selector(toLogin(_:)), for: .touchUpInside)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: CommunityFirstSectionWriteTVCell.reuseIdentifier) as! CommunityFirstSectionWriteTVCell
                cell.nextBtn.addTarget(self, action: #selector(toNext(_:)), for: .touchUpInside)
                
                return cell
            }
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CommunityTVCell.reuseIdentifier) as! CommunityTVCell
            
            cell.configure(index: indexPath.row, data: sampleData[indexPath.row])
            cell.delegate = self
            cell.scrapBtn.tag = indexPath.row
           
            cell.scrapBtn.addTarget(self, action: #selector(scrap(_:)), for: .touchUpInside)
            
            return cell
        }
        
    }
    
    @objc func toNext(_ sender : UIButton){
        if let communityWriteVC = self.storyboard?.instantiateViewController(withIdentifier:CommunityWriteVC.reuseIdentifier) as? CommunityWriteVC {
            self.present(communityWriteVC, animated: true, completion: nil)
        }
        
    }
    
    @objc func toLogin(_ sender : UIButton){
         let rankStoryboard = Storyboard.shared().rankStoryboard
        if let loginVC = rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
            loginVC.entryPoint = 1
            self.present(loginVC, animated: true, completion: nil)
        }
    }
    
    @objc func scrap(_ sender : UIButton){
        //다른 뷰로 넘길때 userId 같이 넘기면 (나중에는 댓글에 대한 고유 인덱스가 됨) 그거 가지고 다시 통신
        //let userName = sampleData[sender.tag].name
        simpleAlertwithHandler(title: "스크랩", message: "스크랩하시겠습니까?") { (_) in
            // print(userName)
        }
    }
}

//키보드 엔터 버튼 눌렀을 때
extension CommunityVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            simpleAlert(title: "오류", message: "검색어 입력")
            return false
        }
        
        if let myString = textField.text {
            let emptySpacesCount = myString.components(separatedBy: " ").count-1
            
            if emptySpacesCount == myString.count {
                simpleAlert(title: "오류", message: "검색어 입력")
                return false
            }
        }
        //TODO - 확인 누르면 데이터 로드하는 통신 코드
        
        if let communityResultTVC = self.storyboard?.instantiateViewController(withIdentifier:CommunityResultTVC.reuseIdentifier) as? CommunityResultTVC {
            textField.resignFirstResponder()
            //searchLegislatorResultTVC = self.selectedCategory
            // communityResultTVC.searchTxtfield.text = self.searchTxtfield.text
            communityResultTVC.searchString = self.searchTxtfield.text
            self.navigationController?.pushViewController(communityResultTVC, animated: true)
        }
        
        
        return true
    }
}


//키보드 대응
extension CommunityVC{
    func setKeyboardSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        blackView.isHidden = false
        adjustKeyboardDismissGesture(isKeyboardVisible: true)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        blackView.isHidden = true
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
        
    }
    
    //화면 바깥 터치했을때 키보드 없어지는 코드
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
        //내 텍필
        self.view.endEditing(true)
    }
}

//refreshControl
extension CommunityVC{
    
    @objc func startReloadTableView(_ sender: UIRefreshControl){
        let aa = Sample(profileUrl: #imageLiteral(resourceName: "dabi"), name: "다비다비", time: "1시간 전", content: "새로고침 ", like: 3, comment: 5, contentImg: nil, heart: true, scrap: false)
        sampleData.append(aa)
        
        self.communityTableView.reloadData()
        sender.endRefreshing()
    }
}

//탭제스처 레코그나이저
extension CommunityVC :  UIGestureRecognizerDelegate, TapDelegate {
    func myTableDelegate(index : Int) {
        print(index)
    }
}



