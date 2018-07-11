//
//  BoardDetailViewController.swift
//  sopt22_seminar4_1
//
//  Created by 강수진 on 2018. 4. 30..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class BoardDetailViewController: UIViewController, APIService {
    
    // 화면 터치했을 때 키보드 사라지게 하는 gesture
    var keyboardDismissGesture: UITapGestureRecognizer?
    
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var commentSendView: UIView!
    @IBOutlet weak var commentTxt: UITextView!
        @IBOutlet weak var likeCountLbl: UILabel!
        @IBOutlet weak var commentCountLbl: UILabel!

    var heartCount = 0
    var commentCount = 0
    var selectedBoard : Int? {
        didSet {
            if let selectedBoard_ = selectedBoard {
                getCommentList(url: url("/board/commentlist/\(selectedBoard_)"))
            }
            
        }
    }
    var commentData : [CommunityCommentVOData]?
    @IBAction func dissmissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
  
    
    @IBAction func writeCommentBtn(_ sender: Any) {
       writeComment(url : url("/board/makecomment"))
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
        if let selectedBoard_ = selectedBoard {
            getCommentList(url: url("/board/commentlist/\(selectedBoard_)"))
        }
        commentTxt.layer.cornerRadius = commentTxt.frame.height/2
        commentTxt.clipsToBounds = true 
        
    }
    
    //comment댓글 글자 수 제한
  /*  @objc func canCommentSend() {
        if commentWriteField.text == "" { //입력안됐을때
            //버튼 활성화 안되고 유저 인터렉션 불가
            commentSendBtn.isUserInteractionEnabled = false
            simpleAlert(title: "오류", message: "댓글을 입력해주세요")
            //commentSendBtn.isEnabled = false// 아님//
        } else if ((commentWriteField.text?.count)! < 100){
            //버튼 활성화 되고 유저 인터렉션 가능
            commentSendBtn.isUserInteractionEnabled = true
            //버튼 활성화, 이미지 색 바꾸기
            commentSendBtn.tintColor = #colorLiteral(red: 0.2117647059, green: 0.7725490196, blue: 0.9450980392, alpha: 1)
            commentSendBtn.isEnabled = true
        } else {
            guard let commentTxt = commentWriteField.text else {return}
            simpleAlert(title: "오류", message: "100글자 초과")
            commentWriteField.text = String(describing: commentTxt.prefix(99))
            //버튼 활성화 되고 유저 인터렉션 가능
            commentSendBtn.isUserInteractionEnabled = true
            //버튼 활성화, 이미지 색 바꾸기
            commentSendBtn.tintColor = #colorLiteral(red: 0.2117647059, green: 0.7725490196, blue: 0.9450980392, alpha: 1)
            commentSendBtn.isEnabled = true
        }
    }*/
    
 
    
}

extension BoardDetailViewController : UITableViewDataSource, UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let commentData_ = commentData {
            return commentData_.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        if let commentData_ = commentData {
            cell.configure(index : indexPath.row ,data: commentData_[indexPath.row])
        }
        
       // cell.delegate = self
        return cell
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        if indexPath.section == 0{
//            return false
//        }
//        return true
//    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if (editingStyle == .delete) {
//            let selectedComment = self.comments[indexPath.row]
//            let commentIdx = selectedComment.comment_idx
//            let userIdx = LoginUserData.shared().data?.user_idx
//            let commentModel = CommentModel(self)
//            commentModel.deleteComment(userIdx: userIdx!, commentIdx: commentIdx!)
//        }
//    }
    
    
    
}


extension BoardDetailViewController {
    
   
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
extension BoardDetailViewController : TapDelegate, UIGestureRecognizerDelegate {
    func myTableDelegate(index: Int) {
        print(index)
    }
  
}
//통신
extension BoardDetailViewController {
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
        getCommentList(url : url("/board/commentlist/\(gino(selectedBoard))"))
    }
    
    //댓글달기
    func writeComment(url : String){
        
        let params : [String : Any] = [
            "board_id" : selectedBoard ?? 0,
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
    
}

