//
//  CommunityTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 1..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit


class CommunityVC: UIViewController, UISearchBarDelegate, APIService, ReportDelegate {
    
    @IBOutlet weak var badgeImg: UIImageView!
    @IBOutlet weak var alarmLbl: UILabel!
    @IBOutlet weak var searchTxtfield: UITextField!
    @IBOutlet weak var separateView: UIView!
    @IBOutlet weak var communityTableView: UITableView!
    @IBOutlet weak var alarmBtn: UIButton!
    
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
    var userImgURL : String?
    
    @IBAction func mypageBtn(_ sender: Any) {
        //마이페이지 통신
        let mypageVC = Storyboard.shared().mypageStoryboard.instantiateViewController(withIdentifier: MyPageVC.reuseIdentifier) as! MyPageVC
        let myId = UserDefaults.standard.string(forKey: "userIdx") ?? "-1"
        if (myId == "-1"){
            self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
                if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
                    loginVC.entryPoint = 1
                    self.present(loginVC, animated: true, completion: nil)
                }
            })
            
        } else {
            mypageVC.selectedUserId = myId
            self.present(mypageVC, animated: true, completion: nil)
        }
    }

    func getAlarm(alarmCount: Int) {
        if alarmCount == 0 {
            alarmLbl.isHidden = true
            badgeImg.isHidden = true
        } else {
            alarmLbl.isHidden = false
            badgeImg.isHidden = false
            if alarmCount > 99 {
                alarmLbl.text = "99+"
            } else {
                  alarmLbl.text = "\(alarmCount)"
            }

        }
    }

    override func viewWillAppear(_ animated: Bool) {
        searchTxtfield.text = ""
        //searchTxtfield.resignFirstResponder()
        //원래 이 뷰가 첫번째로 뜨면 너무 빨리 떠서 userIdx 가 0인 상태
        let userIdx = UserDefaults.standard.string(forKey: "userToken") ?? "-1"
        //유저가 로그인 되어있는지 아닌지 체크
        if userIdx == "-1" {
            login = false
        } else {
            login = true
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        communityWriteVC = self.storyboard?.instantiateViewController(withIdentifier:CommunityWriteVC.reuseIdentifier) as? CommunityWriteVC
        communityWriteVC?.delegate = self
        self.navigationController?.isNavigationBarHidden = true
        searchTxtfield.delegate = self
        communityTableView.dataSource = self
        communityTableView.delegate = self
        
        self.communityTableView.refreshControl = UIRefreshControl()
        self.communityTableView.refreshControl?.addTarget(self, action: #selector(startReloadTableView(_:)), for: .valueChanged)
        alarmLbl.sizeToFit()
        searchTxtfield.enablesReturnKeyAutomatically = false
        self.communityTableView.addSubview(blackView)
        alarmBtn.addTarget(self, action:  #selector(toAlarmVC(_sender:)), for: .touchUpInside)
        setKeyboardSetting()
        blackView.isHidden = true
        //constraint-----------------------------------------
        blackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(separateView.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            alarmLbl.adjustsFontSizeToFitWidth = true
        }
        
        //통신
        let itemCount = communityData.count.description
        communityInit(url : UrlPath.Board.getURL(itemCount))
        
    } //viewDidLoad
    
    override func viewWillDisappear(_ animated: Bool) {
        searchTxtfield.resignFirstResponder()
    }
    
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
                cell.configure(self.gsno(userImgURL))
                
                cell.nextBtn.addTarget(self, action: #selector(toWrite(_:)), for: .touchUpInside)
                
                return cell
            }
            
        } else {
            guard communityData.count > 0 else {return UITableViewCell()}
            if (gsno(communityData[indexPath.row].img) != "0") {
                let cell = tableView.dequeueReusableCell(withIdentifier: CommunityTVCell.reuseIdentifier) as! CommunityTVCell
  
                cell.configure(index: indexPath.row, data: communityData[indexPath.row])
                cell.delegate = self
                
                let temp = communityData[indexPath.row]
                //여기는 스크랩했냐 아니냐
                cell.scrapBtn.tag = temp.boardid
                cell.commentBtn.tag = (temp.boardid)
                cell.heartBtn.boardIdx = temp.boardid
                cell.heartBtn.isLike = temp.islike
                cell.heartBtn.indexPath = indexPath.row
                cell.scrapBtn.addTarget(self, action: #selector(scrap(_:)), for: .touchUpInside)
                cell.commentBtn.addTarget(self, action: #selector(comment(_:)), for: .touchUpInside)
                cell.heartBtn.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
                cell.warningBtn.delegate = self
                return cell
                
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: CommunityNoImgTVCell.reuseIdentifier) as! CommunityNoImgTVCell
                
                cell.configure(index: indexPath.row, data: communityData[indexPath.row])
                cell.delegate = self
               
                let temp = communityData[indexPath.row]
                //여기는 스크랩했냐 아니냐
                cell.scrapBtn.tag = temp.boardid
                cell.commentBtn.tag = (temp.boardid)
                cell.heartBtn.boardIdx = temp.boardid
                cell.heartBtn.isLike = temp.islike
                cell.heartBtn.indexPath = indexPath.row
                cell.scrapBtn.addTarget(self, action: #selector(scrap(_:)), for: .touchUpInside)
                cell.commentBtn.addTarget(self, action: #selector(comment(_:)), for: .touchUpInside)
                cell.heartBtn.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
                cell.warningBtn.delegate = self
                return cell
            }
        }
        
    }
 
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let section = indexPath.section
        if section == 1 {
            guard communityData.count > 0 else {return}
            let lastItemIdx = communityData.count-1
            let itemIdx = communityData[lastItemIdx].boardid.description
            if indexPath.row == lastItemIdx {
                communityInit(url : UrlPath.Board.getURL(itemIdx))
            }
        }
    }
}

//셀들에 관한 액션 -> 글쓰기/로그인/스크랩/신고
extension CommunityVC {
    
    @objc func toWrite(_ sender : UIButton){
        write(url: UrlPath.WriteBoard.getURL())
    }
    
    @objc func toLogin(_ sender : UIButton){
        let rankStoryboard = Storyboard.shared().rankStoryboard
        if let loginVC = rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
            loginVC.entryPoint = 1
            self.present(loginVC, animated: true, completion: nil)
        }
    }
    
    @objc func scrap(_ sender : UIButton){
        let boardIdx = sender.tag
        
        simpleAlertwithHandler(title: "스크랩", message: "스크랩하시겠습니까?") { (_) in
            self.scrapAction(url: UrlPath.Board.getURL(), boardIdx: boardIdx)
        }
    }
    
    @objc func comment(_ sender : myCommentBtn){
        let communityStoartyboard = Storyboard.shared().communityStoryboard
        
        if let commentVC = communityStoartyboard.instantiateViewController(withIdentifier:CommentVC.reuseIdentifier) as? CommentVC {
            
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
        
        var cell : UITableViewCell?
        if let imgCell = self.communityTableView.cellForRow(at: indexPath!) as? CommunityTVCell {
            cell = imgCell
        }
        
        if let noImgCell = self.communityTableView.cellForRow(at: indexPath!) as? CommunityNoImgTVCell {
            cell = noImgCell
        }
       
        if sender.isLike! == 0 {
            likeAction(url: UrlPath.LikeBoard.getURL(), boardIdx : sender.boardIdx!, isLike : sender.isLike!, cell : cell!, sender : sender, likeCnt: sender.likeCnt )
        } else {
            dislikeAction(url: UrlPath.LikeBoard.getURL(sender.boardIdx!.description), cell : cell!, sender : sender, likeCnt: sender.likeCnt )
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
        if let searchString_ = textField.text {
            searchBoard(searchString : searchString_, url : UrlPath.SearchBoard.getURL(searchString_))
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
        communityData = []
        let itemCount = communityData.count.description
        communityInit(url : UrlPath.Board.getURL(itemCount))
        sender.endRefreshing()
    }
}

extension CommunityVC : TapDelegate {
    //글쓰기에서 돌아왔을 때
    func myTableDelegate(index: Int) {
        communityData = []
        let itemCount = communityData.count.description
        communityInit(url : UrlPath.Board.getURL(itemCount))
    }
}

//탭제스처 레코그나이저
extension CommunityVC :  UIGestureRecognizerDelegate, TapDelegate2 {
    func myTableDelegate(sender : UITapGestureRecognizer) {
        let touch = sender.location(in: communityTableView)
        if let indexPath = communityTableView.indexPathForRow(at: touch){
            var userId = ""
            if let cell = self.communityTableView.cellForRow(at: indexPath) as? CommunityTVCell {
                userId = cell.profileImgView.userId
            }
            if let cell = self.communityTableView.cellForRow(at: indexPath) as? CommunityNoImgTVCell {
                userId = cell.profileImgView.userId
            }
            //let userId = cell.profileImgView.userId
            let myId = UserDefaults.standard.string(forKey: "userIdx") ?? "-1"
            if (myId == userId ){
                //내걸로
                if let myPageVC = Storyboard.shared().mypageStoryboard.instantiateViewController(withIdentifier:MyPageVC.reuseIdentifier) as? MyPageVC {
                    myPageVC.selectedUserId = userId
                    self.present(myPageVC, animated: true, completion: nil)
                }
            } else {
                //남의걸로
                if let otherUserPageVC = Storyboard.shared().subStoryboard.instantiateViewController(withIdentifier:OtherUserPageVC.reuseIdentifier) as? OtherUserPageVC {
                    otherUserPageVC.selectedUserId = userId
                    self.present(otherUserPageVC, animated: true, completion: nil)
                }
            }
            
        }
    }
    
    
}


extension CommunityVC {
    @objc func toAlarmVC(_sender: UIButton){
        if let noticeVC = Storyboard.shared().subStoryboard.instantiateViewController(withIdentifier:NoticeVC.reuseIdentifier) as? NoticeVC {
            
            let myId = UserDefaults.standard.string(forKey: "userIdx") ?? "-1"
            if (myId == "-1"){
                self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
                    if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
                        loginVC.entryPoint = 1
                        self.present(loginVC, animated: true, completion: nil)
                    }
                })
                
            } else {
                self.present(noticeVC, animated : true)
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
                if communityContent.content.count > 0 {
                    self.communityData.append(contentsOf: communityContent.content)
                    self.communityTableView.reloadData()
                }
                self.userImgURL = communityContent.userImgURL
                self.getAlarm(alarmCount: communityContent.alarmcnt)
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
                let img = legislatorData as? String
                self.communityWriteVC?.imgURL = img
                self.toCommunityWriteVC()
                break
            case .accessDenied :
                self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
                    if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
                        loginVC.entryPoint = 1
                        self.present(loginVC, animated: true, completion: nil)
                    }
                })
            case .networkFail :
                self.simpleAlert(title: "network", message: "check")
            default :
                break
            }
            
        })
        
    }
    
    
    //하트 버튼 눌렀을 때
    func likeAction(url : String, boardIdx : Int, isLike : Int, cell : UITableViewCell, sender : myHeartBtn, likeCnt : Int){
        let params : [String : Any] = [
            "board_id" : boardIdx
        ]
        CommunityLikeService.shareInstance.like(url: url, params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = true
                sender.isLike = 1
                self.communityData[sender.indexPath].islike = 1
                 self.communityData[sender.indexPath].likecnt += 1
                
                var changed : Int = 0
                //Now change the text and background colour
                
                let tempCell : UITableViewCell = cell
                if let imgCell = tempCell as? CommunityTVCell {
                    if imgCell.likeLabel.text == "\(likeCnt)" {
                        changed = likeCnt+1
                    } else {
                        changed = likeCnt
                    }
                    imgCell.likeLabel.text = "\(changed)"
                    
                }
                
                if let noImgCell = tempCell as? CommunityNoImgTVCell {
                    if noImgCell.likeLabel.text == "\(likeCnt)" {
                        changed = likeCnt+1
                    } else {
                        changed = likeCnt
                    }
                    noImgCell.likeLabel.text = "\(changed)"
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
    func dislikeAction(url : String, cell : UITableViewCell, sender : myHeartBtn, likeCnt : Int){
        CommunityDislikeService.shareInstance.dislikeCommunity(url: url, completion: {  [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = false
                sender.isLike = 0
                self.communityData[sender.indexPath].islike = 0
                self.communityData[sender.indexPath].likecnt -= 1
                var changed : Int = 0
                
                let tempCell : UITableViewCell = cell
                if let imgCell = tempCell as? CommunityTVCell {
                    if imgCell.likeLabel.text == "\(likeCnt)" {
                        changed = likeCnt-1
                    } else {
                        changed = likeCnt
                    }
                    imgCell.likeLabel.text = "\(changed)"
                    
                }
                
                if let noImgCell = tempCell as? CommunityNoImgTVCell {
                    if noImgCell.likeLabel.text == "\(likeCnt)" {
                        changed = likeCnt-1
                    } else {
                        changed = likeCnt
                    }
                    noImgCell.likeLabel.text = "\(changed)"
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
    
    //보드 스크랩
    func scrapAction(url : String, boardIdx : Int){
        
        let params : [String : Any] = [
            "shared" : boardIdx
        ]
        CommunityWriteCompleteService.shareInstance.registerBoard(url: url, params: params, image: [:], completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(_):
                self.simpleAlert(title: "성공", message: "스크랩 성공했습니다")
            case .accessDenied :
                self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
                    if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
                        loginVC.entryPoint = 1
                        self.present(loginVC, animated: true, completion: nil)
                    }
                })
            case .failInsert :
                self.simpleAlert(title: "오류", message: "스크랩 실패했습니다")
            case .networkFail :
                self.simpleAlert(title: "오류", message: "인터넷 연결상태를 확인해주세요")
            default :
                break
            }
        })
        
        
    }

    //보드 서치
    func searchBoard(searchString : String, url : String){
        CommunitySearchService.shareInstance.searchBoard(url: url) { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let communitySearchData):
                let communitySearchData = communitySearchData as! [CommunitySearchVOData]
                
                self.toSearchResultPage(searchString: searchString, communitySearchData: communitySearchData)
                break
            case .nullValue :
                self.simpleAlert(title: "오류", message: "검색 결과가 없습니다")
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
        }
    }
    
    func toSearchResultPage(searchString : String, communitySearchData : [CommunitySearchVOData]){
        let communityStoryboard = Storyboard.shared().communityStoryboard
        if let communitySearchResultTVC = communityStoryboard.instantiateViewController(withIdentifier:CommunityResultTVC.reuseIdentifier) as? CommunityResultTVC {
            communitySearchResultTVC.searchString = searchString
            communitySearchResultTVC.communitySearchData = communitySearchData
            self.navigationController?.pushViewController(communitySearchResultTVC, animated: true)
        }
    }
}




