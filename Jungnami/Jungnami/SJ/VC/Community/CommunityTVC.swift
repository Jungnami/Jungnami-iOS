//
//  CommunityTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 1..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class CommunityTVC: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var badgeImg: UIImageView!
    @IBOutlet weak var alarmLbl: UILabel!
    
    
    lazy var blackView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.4
        return view
    }()
    
    
    
    var keyboardDismissGesture: UITapGestureRecognizer?
    
    @IBOutlet weak var searchTxtfield: UITextField!
    
    @IBAction func mypageBtn(_ sender: Any) {
    }
    
    @IBAction func alarmBtn(_ sender: Any) {
    }
    
    @IBOutlet weak var separateView: UIView!
    var sampleData : [Sample] = []
    
    override func viewWillAppear(_ animated: Bool) {
        searchTxtfield.text = ""
    }
    ////////SampleData//////
    let badgeCount = 18
    //////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTxtfield.delegate = self
        setKeyboardSetting()
        alarmLbl.sizeToFit()
        searchTxtfield.enablesReturnKeyAutomatically = false
        self.navigationController?.isNavigationBarHidden = true
        self.tableView.addSubview(blackView)
        blackView.isHidden = true
        blackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(separateView.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            alarmLbl.adjustsFontSizeToFitWidth = true
            if(badgeCount > 99){
                alarmLbl.text = "99+"
            } else {
                alarmLbl.text = "\(badgeCount)"
            }
            
        }
        
        //refreshControl
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(startReloadTableView(_:)), for: .valueChanged)
        
        //////////////////////뷰 보기 위한 샘플 데이터//////////////////////////
        addChildView(containerView: containerView, asChildViewController: writeVC)
        let a = Sample(profileUrl: #imageLiteral(resourceName: "dabi"), name: "다비다비", time: "1시간 전", content: "다비 최고야,, 형윤 최고야,, 디자인 세상에서 제일 예뻐요 선생님들,, ", like: 3, comment: 5, contentImg: nil, heart: true, scrap: false)
        let b = Sample(profileUrl: #imageLiteral(resourceName: "community_character"), name: "제리", time: "4시간 전", content: "픽미픽미픽미업", like: 73, comment: 6020, contentImg: #imageLiteral(resourceName: "inni"), heart: false, scrap: true)
        
        sampleData.append(a)
        sampleData.append(b)
        ////////////////////////////////////////////////////
        
        
    }
    
    
    //TODO
    //1. 나중에 유저가 로그인 되어있냐 안되어 있냐에 따라서 addChildView, removeChildView 함수 이용해서 보이는 뷰 바뀌게 하기
    //2. 만약 알람 없으면 뱃지 안보이게
    
    private lazy var needLoginVC: NeedLoginVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: NeedLoginVC.reuseIdentifier) as! NeedLoginVC
        return viewController
    }()
    
    private lazy var writeVC: WriteVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: WriteVC.reuseIdentifier) as! WriteVC
        return viewController
    }()
    
    
    
}

//tableView deleagete, datasource
extension CommunityTVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sampleData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommunityTVCell.reuseIdentifier) as! CommunityTVCell
        
        cell.configure(data: sampleData[indexPath.row])
        
        cell.scrapBtn.tag = indexPath.row
//        cell.scrapBtn.isUserInteractionEnabled = true
        cell.scrapBtn.addTarget(self, action: #selector(scrap(_:)), for: .touchUpInside)
        
        return cell
        
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
extension CommunityTVC: UITextFieldDelegate {
    
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
            
            self.navigationController?.pushViewController(communityResultTVC, animated: true)
        }
        
        
        return true
    }
}


//키보드 대응
extension CommunityTVC{
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

extension CommunityTVC{
    
    @objc func startReloadTableView(_ sender: UIRefreshControl){
         let aa = Sample(profileUrl: #imageLiteral(resourceName: "dabi"), name: "다비다비", time: "1시간 전", content: "새로고침 ", like: 3, comment: 5, contentImg: nil, heart: true, scrap: false)
        sampleData.append(aa)
        
        self.tableView.reloadData()
        sender.endRefreshing()
    }
}


