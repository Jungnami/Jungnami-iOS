//
//  ContentCommentVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 12..
//

import UIKit

class ContentCommentVC: UIViewController, APIService {
    
    // 화면 터치했을 때 키보드 사라지게 하는 gesture
    var keyboardDismissGesture: UITapGestureRecognizer?
    
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var commentSendView: UIView!
    @IBOutlet weak var commentTxt: UITextView!
    @IBOutlet weak var likeCountLbl: UILabel!
    @IBOutlet weak var commentCountLbl: UILabel!
    
    var heartCount = 0
    var commentCount = 0
    var selectedContent : Int? {
        didSet {
            if let selectedContent_ = selectedContent {
                getCommentList(url: url("/contents/commentlist/\(selectedContent_)"))
            }
            
        }
    }
    var commentData : [CommunityCommentVOData]?
    @IBAction func dissmissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func writeCommentBtn(_ sender: Any) {
        writeComment(url : url("/contents/makecomment"))
        commentTxt.text = ""
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTableView.tableFooterView = UIView(frame : .zero)
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.tableFooterView = UIView(frame : .zero)
        //commentTxt.addTarget(self, action: #selector(canCommentSend), for: .editingChanged)
        setKeyboardSetting()
        likeCountLbl.text = "\(heartCount)명이 좋아합니다"
        likeCountLbl.sizeToFit()
        commentCountLbl.text = "\(commentCount)개"
        if let selectedContent_ = selectedContent {
            getCommentList(url: url("/contents/commentlist/\(selectedContent_)"))
        }
        commentTxt.layer.cornerRadius = commentTxt.frame.height/2
        commentTxt.clipsToBounds = true
        
    }
    
    
    
    
}

extension ContentCommentVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let commentData_ = commentData {
            return commentData_.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        if let commentData_ = commentData {
             cell.commentLikeBtn.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
            cell.configure(index : indexPath.row ,data: commentData_[indexPath.row])
        }
        
      
        return cell
    }
    
    
    @objc func like(_ sender : myHeartBtn){
        //통신
        
        let buttonPosition = sender.convert(CGPoint.zero, to: self.detailTableView)
        let indexPath: IndexPath? = self.detailTableView.indexPathForRow(at: buttonPosition)
        let cell = self.detailTableView.cellForRow(at: indexPath!) as! CommentCell
        
        if sender.isLike! == 0 {
            
            likeAction(url: url("/contents/likecomment"), boardIdx : sender.boardIdx!, isLike : sender.isLike!, cell : cell, sender : sender, likeCnt: sender.likeCnt )
        } else {
            
            dislikeAction(url: url("/delete/contentscommentlike/\(sender.boardIdx!)"), cell : cell, sender : sender, likeCnt: sender.likeCnt )
        }
        
    }
    
    
}


extension ContentCommentVC {
    
    
    func setKeyboardSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: true)
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            var contentInset = self.detailTableView.contentInset
            contentInset.bottom = keyboardSize.height
            detailTableView.contentInset = contentInset
            ////////
            //////// 키보드의 사이즈만큼 commentSendView의 y축을 위로 이동시킴 ////////
            commentSendView.frame.origin.y -= keyboardSize.height
            ////////
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var contentInset = self.detailTableView.contentInset
            contentInset.bottom = 0
            detailTableView.contentInset = contentInset
            //////// 키보드의 사이즈만큼 commentSendView의 y축을 아래로 이동시킴 ////////
            commentSendView.frame.origin.y += keyboardSize.height
            ////////
            self.view.layoutIfNeeded()
        }
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

//tapGesture
extension ContentCommentVC : TapDelegate, UIGestureRecognizerDelegate {
    func myTableDelegate(index: Int) {
        print(index)
    }
    
}
//통신
extension ContentCommentVC {
    func getCommentList(url : String){
        CommunityCommentService.shareInstance.getCommunity(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(let commentData):
                let commentData1 = commentData as! [CommunityCommentVOData]
                self.commentData = commentData1
                self.detailTableView.reloadData()
                
                break
            case .accessDenied :
                self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
                    if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
                        loginVC.entryPoint = 1
                        self.present(loginVC, animated: true, completion: nil)
                    }
                })
                break
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
        
    }
    
    func temp(){
       
        getCommentList(url : url("/contents/commentlist/\(selectedContent!)"))
    }
    
    //댓글달기
    func writeComment(url : String){
        
        let params : [String : Any] = [
            "contents_id" : selectedContent ?? 0,
            "content" : commentTxt.text ?? ""
        ]
        
        
        CommunityCommentWriteService.shareInstance.commentWrite(url: url, params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(_):
                self.temp()
                
            case .accessDenied :
                self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
                    if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
                        loginVC.entryPoint = 1
                        self.present(loginVC, animated: true, completion: nil)
                    }
                })
            case .networkFail :
                self.simpleAlert(title: "오류", message: "인터넷 연결상태를 확인해주세요")
            default :
                break
            }
        })
        
        
    }
    
    //하트 버튼 눌렀을 때
    func likeAction(url : String, boardIdx : Int, isLike : Int, cell : CommentCell, sender : myHeartBtn, likeCnt : Int){
        
        let params : [String : Any] = [
            "comment_id" : boardIdx
        ]
        CommunityLikeService.shareInstance.like(url: url, params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = true
                sender.isLike = 1
              

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
    func dislikeAction(url : String, cell : CommentCell, sender : myHeartBtn, likeCnt : Int){
        CommunityDislikeService.shareInstance.dislikeCommunity(url: url, completion: {  [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = false
                sender.isLike = 0
               
                
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

