//
//  CommunityResultTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 4..
//

import UIKit

class CommunityResultTVC: UITableViewController, APIService {
    
    @IBOutlet weak var searchTxtfield: UITextField!
    @IBOutlet weak var separateView: UIView!
    var communitySearchData : [CommunitySearchVOData] = []
    var searchString : String?
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    lazy var blackView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.4
        return view
    }()
    
    var keyboardDismissGesture: UITapGestureRecognizer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchTxtfield.text = searchString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTxtfield.delegate = self
        setKeyboardSetting()
        
        self.tableView.addSubview(blackView)
        blackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(separateView.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            
        }
        blackView.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchTxtfield.resignFirstResponder()
    }
    
    
}

//데이터소스, 딜리게이트 
extension CommunityResultTVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return communitySearchData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (gsno(communitySearchData[indexPath.row].imgURL) != "0") {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CommunityTVCell.reuseIdentifier) as! CommunityTVCell
            
            cell.configure2(index: indexPath.row, data: communitySearchData[indexPath.row])
            cell.delegate = self
            //탭제스처레코그나이저 -> 두번탭 처리하면 주석 풀기
            //cell.doubleTapdelegate = self
            let temp = communitySearchData[indexPath.row]
            //여기는 스크랩했냐 아니냐
            cell.scrapBtn.tag = temp.id
            cell.commentBtn.tag = (temp.id)
            cell.heartBtn.boardIdx = temp.id
            cell.heartBtn.isLike = temp.islike
            cell.heartBtn.indexPath = indexPath.row
            cell.scrapBtn.addTarget(self, action: #selector(scrap(_:)), for: .touchUpInside)
            cell.commentBtn.addTarget(self, action: #selector(comment(_:)), for: .touchUpInside)
            cell.heartBtn.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
            
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CommunityNoImgTVCell.reuseIdentifier) as! CommunityNoImgTVCell
            
            cell.configure2(index: indexPath.row, data: communitySearchData[indexPath.row])
            cell.delegate = self
            //탭제스처레코그나이저 -> 두번탭 처리하면 주석 풀기
            //cell.doubleTapdelegate = self
            let temp = communitySearchData[indexPath.row]
            //여기는 스크랩했냐 아니냐
            cell.scrapBtn.tag = temp.id
            cell.commentBtn.tag = (temp.id)
            cell.heartBtn.boardIdx = temp.id
            cell.heartBtn.isLike = temp.islike
            cell.heartBtn.indexPath = indexPath.row
            cell.scrapBtn.addTarget(self, action: #selector(scrap(_:)), for: .touchUpInside)
            cell.commentBtn.addTarget(self, action: #selector(comment(_:)), for: .touchUpInside)
            cell.heartBtn.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
            
            return cell
        }
        
        
        
        
        
    }
    
    
}

//셀들에 관한 액션
extension CommunityResultTVC {
    
    
    @objc func scrap(_ sender : UIButton){
        let boardIdx = sender.tag
        
        simpleAlertwithHandler(title: "스크랩", message: "스크랩하시겠습니까?") { (_) in
            self.scrapAction(url: UrlPath.WriteComplete.getURL(), boardIdx: boardIdx)
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
        
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
        let indexPath: IndexPath? = self.tableView.indexPathForRow(at: buttonPosition)
       
        var cell = UITableViewCell()
        if let imgCell = self.tableView.cellForRow(at: indexPath!) as? CommunityTVCell {
            cell = imgCell
        }
        
        if let noImgCell = self.tableView.cellForRow(at: indexPath!) as? CommunityNoImgTVCell {
            cell = noImgCell
        }
        
        if sender.isLike! == 0 {
            likeAction(url: UrlPath.LikeBoard.getURL(), boardIdx : sender.boardIdx!, isLike : sender.isLike!, cell : cell, sender : sender, likeCnt: sender.likeCnt )
        } else {
            dislikeAction(url: UrlPath.LikeBoard.getURL(sender.boardIdx!.description), cell : cell, sender : sender, likeCnt: sender.likeCnt )
        }
        
    }
}


//키보드 엔터 버튼 눌렀을 때
extension CommunityResultTVC : UITextFieldDelegate {
    
    //텍필 비어잇으면 막기
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
        
        //  textField.resignFirstResponder()
        
        //여기서 검색
        if let searchString_ = textField.text {
            searchCommunity(searchString : searchString_, url : UrlPath.SearchBoard.getURL(searchString_))
        }
        
        
        return true
    }
}


//키보드 대응
extension CommunityResultTVC{
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

//탭제스처 레코그나이저
extension CommunityResultTVC :  UIGestureRecognizerDelegate, TapDelegate2 {
    func myTableDelegate(sender : UITapGestureRecognizer) {
        let touch = sender.location(in: self.tableView)
        if let indexPath = self.tableView.indexPathForRow(at: touch){
            var cell : UITableViewCell?
            var userId = ""
            if let imgCell = self.tableView.cellForRow(at: indexPath) as? CommunityTVCell {
                userId = imgCell.profileImgView.userId
                cell = imgCell
                
            }
            
            if let noImgCell = self.tableView.cellForRow(at: indexPath) as? CommunityNoImgTVCell {
                cell = noImgCell
                userId = noImgCell.profileImgView.userId
            }
            
        
            
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

//통신
extension CommunityResultTVC {
    //커뮤 검색
    func searchCommunity(searchString : String, url : String){
        CommunitySearchService.shareInstance.searchBoard(url: url) { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let communitySearchData):
                let communitySearchData = communitySearchData as! [CommunitySearchVOData]
                self.communitySearchData = communitySearchData
                self.searchTxtfield.resignFirstResponder()
                self.tableView.reloadData()
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
                var changed : Int = 0
                
                //Now change the text and background colour
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
}


