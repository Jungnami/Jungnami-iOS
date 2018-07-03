//
//  CommentVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 3..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class CommentVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
     //상단 좋아요, 댓글 LBL
     @IBOutlet weak var likeCountLbl: UILabel!
    @IBOutlet weak var commentCountLbl: UILabel!
    
    
    //tableView
    @IBOutlet weak var CommentTableView: UITableView!
    
    //취소버튼
    @IBAction func dissmissBtn(_ sender: Any) {
        
    }
    
    @IBOutlet weak var commentWriteBar: UIView!
    @IBOutlet weak var commentWriteField: UITextField!
    //댓글 저장Btn
    @IBOutlet weak var commentSendBtn: UIButton!
    
    /////keyboard///
    private var hideStatusBar: Bool = false
    
    override var prefersStatusBarHidden: Bool {
        return hideStatusBar
    }
    /////////////////////////////
    
    
    var keyboardDismissGesture: UITapGestureRecognizer?
    ////////////////샘플데이터//////////////////////
    var comments: [CommentSample] = []
    
    ////////////////////////////////////
    //---------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CommentTableView.delegate = self
        CommentTableView.dataSource = self
        //comment의 댓글 글자수 제한
        commentWriteField.addTarget(self, action: #selector(canCommentSend), for: .editingChanged)
        setKeyboardSetting()
        //상태바 없애
        hideStatusBar = true
        setNeedsStatusBarAppearanceUpdate()
        
        //////////sampleData/////////
        let a = CommentSample(profile: #imageLiteral(resourceName: "dabi"), userId: "daBee", commentContent: "다비야 디팟장해쥬라~!", date: "1시간 전", likeCount: "555", commentCount: "12")
        let b = CommentSample(profile: #imageLiteral(resourceName: "inni"), userId: "dP", commentContent: "12", date: "6시간 전", likeCount: "12", commentCount: "13")
        comments.append(b)
        comments.append(a)

        
    }
    //comment댓글 글자 수 제한
    @objc func canCommentSend() {
        if commentWriteField.text?.count == 0 { //입력안됐을때
            //버튼 활성화 안되고 유저 인터렉션 불가
            commentSendBtn.isUserInteractionEnabled = false
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //----------------tableView---------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //다시!!!!!!!!!!!!!!!!!!!!!1
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        //다시
        cell.commentProfileImg.image = comments[indexPath.row].profile
        cell.commentUserLbl.text = comments[indexPath.row].userId
        cell.commentContentLbl.text = comments[indexPath.row].commentContent
        cell.commentDateLbl.text = comments[indexPath.row].date
        cell.commentLikeLbl.text = comments[indexPath.row].likeCount
//        cell.recommentCountLbl.text = comments[indexPath.row].commentCount
        return cell
    }
   
}

extension CommentVC {
    
    //////// 외우지 않아도 되는 부분입니다. 표시된 부분만 고쳐서 사용하세요. ////////
    // 코드 설명 : 키보드가 나올 때 키보드의 높이를 계산해서 댓글 뷰가 키보드 위에 뜰 수 있도록 합니다.
    //          view.frame을 조정하면 키보드가 나오고 들어갈 때 뷰가 움직이게 되겠지요?
    //          notification : 옵저버라고 생각하시면 됩니다. 시점을 캐치하여 #selector()의 액션이 일어나도록 합니다.
    //                          이 코드에서는 키보드가 나올 때, 들어갈 때 의 시점을 캐치하여 뷰의 frame을 조정합니다.
    func setKeyboardSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: true)
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            //////// 키보드의 사이즈만큼 commentSendView의 y축을 위로 이동시킴 ////////
            commentWriteBar.frame.origin.y -= keyboardSize.height
            ////////
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            //////// 키보드의 사이즈만큼 commentSendView의 y축을 아래로 이동시킴 ////////
            commentWriteBar.frame.origin.y += keyboardSize.height
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
    ////////
}
