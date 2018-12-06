//
//  FollowListVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 8..
//

import UIKit

class FollowListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, APIService {
    
     var keyboardDismissGesture: UITapGestureRecognizer?
    

    @IBOutlet weak var myNavItem: UINavigationItem!
    @IBOutlet weak var followTableView: UITableView!
    @IBOutlet weak var followSearchField: UITextField!
    @IBOutlet weak var followSearchImg: UIImageView!
    var selectedUserId : String? {
        didSet {
         getList()
        }
    }
    
    @IBAction func dismissAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //통신
    var followListData : [FollowListVOData]? {
        didSet {
            if let _ = followListData {
                self.followTableView.reloadData()
            }
        }
    }
    var followerListData : [FollowerListVOData]? {
        didSet {
            if let _ = followerListData {
                self.followTableView.reloadData()
            }
        }
    }
    var entryPoint : Int?
    var navTitle : String?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         getList()
        
        if let navTitle_ = navTitle {
            self.myNavItem.title = navTitle_
        }
    }
    
    func getList(){
        if let selectedUserId_ = selectedUserId, let entryPoint_ = entryPoint {
            if entryPoint_ == 0 {
                followingListInit(url: UrlPath.User.getURL("\(selectedUserId_)/followinglist"))
            } else {
                followerListInit(url: UrlPath.User.getURL("\(selectedUserId_)/followerlist"))
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        followTableView.delegate = self
        followTableView.dataSource = self
        //네비게이션바 히든
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.followSearchField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        //keyboardDown
        setKeyboardSetting()
        getList()
        
        followSearchField.delegate = self
        followTableView.tableFooterView = UIView(frame : .zero)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            
            //data로 연결
            if let followListData_ = followListData {
                return followListData_.count
            }
            
            if let followerListData_ = followerListData {
               return followerListData_.count
            }
        return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: FollowFixedCell.reuseIdentifier, for: indexPath) as! FollowFixedCell
            cell.followFixedLbl.text = "사람"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: FollowCell.reuseIdentifier, for: indexPath) as! FollowCell
            //configure통신
            cell.delegate = self
            
            if let followListData_ = followListData {
                //여기서부터
                cell.followCancelBtn.addTarget(self, action: #selector(follow(_:)), for: .touchUpInside)
                cell.configure(data: followListData_[indexPath.row], index : indexPath.row)
            }
            
            if let followerListData_ = followerListData {
        
                cell.followCancelBtn.addTarget(self, action: #selector(follow(_:)), for: .touchUpInside)
                cell.configure2(data: followerListData_[indexPath.row], index : indexPath.row)
            }
            
            return cell
        }
        
    }
    
    
    @objc func follow(_ sender : followBtn){
        //통신
        let buttonPosition = sender.convert(CGPoint.zero, to: self.followTableView)
        let indexPath: IndexPath? = self.followTableView.indexPathForRow(at: buttonPosition)
        let cell = self.followTableView.cellForRow(at: indexPath!) as! FollowCell
        // 팔로우가 들어온다는 것은 아직 팔로잉 한 상태가 아니라는 것 => 그러니까 .isSelected = false
        //팔로잉이 들어온다는 것은 팔로잉을 하고 있다는것 => 그러니까 .isSelected = true
        if sender.isFollow! == "팔로우" {
            followAction(url: UrlPath.Follow.getURL(), userIdx : sender.userIdx!,  cell : cell, sender : sender )
        } else {
            unfollowAction(url: UrlPath.Follow.getURL("\(sender.userIdx!)"), cell : cell, sender : sender )
        }
        
    }
}


extension FollowListVC : UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("aa")
        guard let entryPoint_ = entryPoint else { return }
        guard let selectedUserId_ = selectedUserId else {return}
       //여기 확인
        
        if textField.text == "" {
            if entryPoint_ == 0 {
                self.followingListInit(url: UrlPath.User.getURL("\(selectedUserId_)/followinglist"))
            } else {
                self.followerListInit(url: UrlPath.User.getURL("\(selectedUserId_)/followerlist"))
            }
            return
        }
        
        
        if let searchString_ = textField.text {
            if entryPoint_ == 0 {
                //팔로잉 검색
                ///user/:f_id/followinglist/search/:keyword
                self.followingListInit(url: UrlPath.User.getURL("\(selectedUserId_)/followinglist/search/\(searchString_)"))
            } else {
                //팔로워 검색
                ///user/:f_id/followerlist/search/:keyword
                self.followerListInit(url: UrlPath.User.getURL("\(selectedUserId_)/followerlist/search/\(searchString_)"))
            }
        }
      
       

    }
    
    
}

extension FollowListVC : TapDelegate, UIGestureRecognizerDelegate {
    func myTableDelegate(index: Int) {
        print(index)
    }
}

//키보드
extension FollowListVC {
    func setKeyboardSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.followTableView.contentInset.bottom = keyboardSize.height
            self.view.layoutIfNeeded()
        }
        adjustKeyboardDismissGesture(isKeyboardVisible: true)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
        self.followTableView.contentInset.bottom = 0
        self.view.layoutIfNeeded()
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
        self.view.endEditing(true)
    }
}


//통신
extension FollowListVC {
    //하트 버튼 눌렀을 때
    func followAction(url : String, userIdx : String,  cell : FollowCell, sender : followBtn){
        
        let params : [String : Any] = [
            "following_id" : userIdx
        ]
        CommunityLikeService.shareInstance.like(url: url, params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = true
                sender.isFollow = "팔로잉"
                if self.followListData != nil {
                    self.followListData![sender.indexPath].isMyFollowing = "팔로잉"
                    
                }
                
                if self.followerListData != nil {
                     self.followerListData![sender.indexPath].isMyFollowing = "팔로잉"
                }

                break
            case .accessDenied :
                self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
                    if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
                        loginVC.entryPoint = 1
                        self.present(loginVC, animated: true, completion: nil)
                    }
                })
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
    }
    
    //좋아요 취소
    func unfollowAction(url : String, cell : FollowCell, sender : followBtn){
        CommunityDislikeService.shareInstance.dislikeCommunity(url: url, completion: {  [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = false
                sender.isFollow = "팔로우"
                if self.followListData != nil {
                    self.followListData![sender.indexPath].isMyFollowing = "팔로우"
                    
                }
                
                if self.followerListData != nil {
                    self.followerListData![sender.indexPath].isMyFollowing = "팔로우"
                }
                break
            case .accessDenied :
                self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
                    if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
                        loginVC.entryPoint = 1
                        self.present(loginVC, animated: true, completion: nil)
                    }
                })
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
    }
}
//통신
extension FollowListVC {
    
    func followingListInit(url : String){
        FollowingListService.shareInstance.getFollowingList(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let followListData):
                //수정
                let followListData_ : [FollowListVOData]? = followListData as? [FollowListVOData]
                self.followListData = followListData_
                self.followTableView.reloadData()
                print("success")
                break
            case .nullValue :
                self.followListData = []
                //self.simpleAlert(title: "오류", message: "값 없음")
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
        
    }
    
    func followerListInit(url : String){
        FollowerListService.shareInstance.getFollowerList(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let followListData):
                //수정
                let followListData_ = followListData as? [FollowerListVOData]
                self.followerListData = followListData_
                break
            case .nullValue :
                self.followerListData = []
                break
                //self.simpleAlert(title: "오류", message: "값 없음")
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
        
    }
}

