//
//  CommunityTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 1..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit


class CommunityVC: UIViewController, UISearchBarDelegate, APIService {
    
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
    var communityWriteVC : CommunityWriteVC?
    var keyboardDismissGesture: UITapGestureRecognizer?
    var communityData : [CommunityVODataContent] = []
    var login : Bool = false {
        didSet {
            communityTableView.reloadData()
        }
    }
    
    @IBAction func mypageBtn(_ sender: Any) {
        
    }
    
    @IBAction func alarmBtn(_ sender: Any) {
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        searchTxtfield.text = ""
        //원래 이 뷰가 첫번째로 뜨면 너무 빨리 떠서 userIdx 가 0인 상태
        let userIdx = UserDefaults.standard.string(forKey: "userToken") ?? "-1"
        //유저가 로그인 되어있는지 아닌지 체크
        if userIdx == "-1" {
            login = false
        } else {
            login = true
        }
        //통신
        communityInit(url : url("/board/boardlist"))
        
        communityWriteVC = self.storyboard?.instantiateViewController(withIdentifier:CommunityWriteVC.reuseIdentifier) as? CommunityWriteVC
    }
    var badgeCount = 0 {
        didSet {
            alarmLbl.text = "\(badgeCount)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        searchTxtfield.delegate = self
        communityTableView.dataSource = self
        communityTableView.delegate = self
        alarmLbl.sizeToFit()
        searchTxtfield.enablesReturnKeyAutomatically = false
        self.communityTableView.addSubview(blackView)
        setKeyboardSetting()
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
        
        
        
    } //viewDidLoad
    
    func toCommunityWriteVC(){
        self.present(communityWriteVC!, animated: true, completion: nil)
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
            return communityData.count
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
                
                //cell.configure(data : )
                cell.nextBtn.addTarget(self, action: #selector(toWrite(_:)), for: .touchUpInside)
                
                return cell
            }
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CommunityTVCell.reuseIdentifier) as! CommunityTVCell
            
            cell.configure(index: indexPath.row, data: communityData[indexPath.row])
            cell.delegate = self
            //탭제스처레코그나이저 -> 두번탭 처리하면 주석 풀기
            //cell.doubleTapdelegate = self
            let temp = communityData[indexPath.row]
            cell.scrapBtn.tag = temp.boardid
            cell.commentBtn.tag = (temp.boardid)
            cell.heartBtn.boardIdx = temp.boardid
            cell.heartBtn.isLike = temp.islike
            cell.heartBtn.indexPath = indexPath.row
            cell.scrapBtn.addTarget(self, action: #selector(scrap(_:)), for: .touchUpInside)
            cell.commentBtn.addTarget(self, action: #selector(comment(_:)), for: .touchUpInside)
            cell.heartBtn.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
            
            return cell
        }
        
    }
    
}

//셀들에 관한 액션 -> 글쓰기/로그인/스크랩
extension CommunityVC {
    
    @objc func toWrite(_ sender : UIButton){
        write(url: url("/board/post"))
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
    
    @objc func comment(_ sender : myCommentBtn){
        let communityStoartyboard = Storyboard.shared().communityStoryboard
        
        if let commentVC = communityStoartyboard.instantiateViewController(withIdentifier:BoardDetailViewController.reuseIdentifier) as? BoardDetailViewController {
            
            commentVC.selectedBoard = sender.tag
            commentVC.heartCount = sender.likeCnt
            commentVC.commentCount = sender.commentCnt
            
            self.present(commentVC, animated: true)
        }
        
    }
    
    @objc func like(_ sender : myHeartBtn){
        //통신
        
        let buttonPosition = sender.convert(CGPoint.zero, to: self.communityTableView)
        let indexPath: IndexPath? = self.communityTableView.indexPathForRow(at: buttonPosition)
        let cell = self.communityTableView.cellForRow(at: indexPath!) as! CommunityTVCell
        
        if sender.isLike! == 0 {
            likeAction(url: url("/board/likeboard"), boardIdx : sender.boardIdx!, isLike : sender.isLike!, cell : cell, sender : sender, likeCnt: sender.likeCnt )
        } else {
            dislikeAction(url: url("/delete/boardlike/\(sender.boardIdx!)"), cell : cell, sender : sender, likeCnt: sender.likeCnt )
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
        communityInit(url : url("/board/boardlist"))
        sender.endRefreshing()
    }
}

//탭제스처 레코그나이저
extension CommunityVC :  UIGestureRecognizerDelegate, TapDelegate, DoubleTapDelegate {
    func myTableDelegate(index: Int) {
        print("\(index)")
    }
    
    
    
    func myDoubleTapDelegate(sender : UITapGestureRecognizer) {
        let touch = sender.location(in: communityTableView)
        if let indexPath = communityTableView.indexPathForRow(at: touch){
            let cell = self.communityTableView.cellForRow(at: indexPath) as! CommunityTVCell
            let boardIdx = cell.heartBtn.boardIdx
            let isLike = cell.heartBtn.isLike
            let sender = cell.heartBtn
            let likeCount = cell.heartBtn.likeCnt
            touchLikeAction(url: url("/board/likeboard"), boardIdx : boardIdx!, isLike : isLike!, cell : cell, sender : sender!, likeCnt: likeCount )
            
        }
    }
    
    func heartPopup(){
        DispatchQueue.main.asyncAfter(deadline: .now()){
            var myPopupImgView = UIImageView()
            myPopupImgView = self.setImgView(viewName: myPopupImgView, fileName: "community_heart_blue")
            self.view.addSubview(myPopupImgView)
            myPopupImgView.widthAnchor.constraint(equalToConstant: 50).isActive = true
            myPopupImgView.heightAnchor.constraint(equalToConstant: 50).isActive = true
            myPopupImgView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            myPopupImgView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            myPopupImgView.contentMode = .scaleAspectFit
            
            
            //self.setImageViewConstraints(myPopupImgView)
            myPopupImgView.isHidden = false
            myPopupImgView.expand()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                myPopupImgView.isHidden = true
            }
        }
    }
}

//통신
extension CommunityVC {
    //커뮤 들어갔을 때
    func communityInit(url : String){
        CommunityService.shareInstance.getCommunity(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(let communityData):
                let communityContent = communityData as! CommunityVOData
                self.communityData = communityContent.content
                self.communityTableView.reloadData()
                self.badgeCount = communityContent.alarmcnt
                break
            case .nullValue :
                break
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
        
    }
    
    //글쓰기 눌렀을 때
    func write(url : String){
        CommunityWriteService.shareInstance.communityWrite(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let legislatorData):
                let img = legislatorData as! CommunityWriteVOData
                self.communityWriteVC?.imgURL = img.imgURL
                
                
                self.toCommunityWriteVC()
                break
            case .accessDenied :
                self.simpleAlert(title: "오류", message: "로그인을 해주세요")
            case .networkFail :
                self.simpleAlert(title: "network", message: "check")
            default :
                break
            }
            
        })
        
    }
    
    func touchLikeAction(url : String, boardIdx : Int, isLike : Int, cell : CommunityTVCell, sender : myHeartBtn, likeCnt : Int){
        let params : [String : Any] = [
            "board_id" : boardIdx
        ]
        CommunityLikeService.shareInstance.like(url: url, params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = true
                sender.isLike = 1
                
                var changed : Int = 0
                //Now change the text and background colour
                if sender.isLike != 1 {
                     changed = likeCnt+1
                } else {
                     changed = likeCnt
                }
                cell.likeLabel.text = "\(changed)"
                self.heartPopup()
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
    
    func likeAction(url : String, boardIdx : Int, isLike : Int, cell : CommunityTVCell, sender : myHeartBtn, likeCnt : Int){
        let params : [String : Any] = [
            "board_id" : boardIdx
        ]
        CommunityLikeService.shareInstance.like(url: url, params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = true
                sender.isLike = 1
                
                var changed : Int = 0
                //Now change the text and background colour
                if cell.likeLabel.text == "\(likeCnt)" {
                    changed = likeCnt+1
                } else {
                    changed = likeCnt
                }
                cell.likeLabel.text = "\(changed)"
                
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
    
    func dislikeAction(url : String, cell : CommunityTVCell, sender : myHeartBtn, likeCnt : Int){
        CommunityDislikeService.shareInstance.dislikeCommunity(url: url, completion: {  [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = false
                sender.isLike = 0
                var changed : Int = 0
                
                //Now change the text and background colour
                if cell.likeLabel.text == "\(likeCnt)" {
                    changed = likeCnt-1
                } else {
                    changed = likeCnt
                }
                cell.likeLabel.text = "\(changed)"
                
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
}


