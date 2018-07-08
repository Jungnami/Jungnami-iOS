//
//  CommentVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 3..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit
import SnapKit

class CommentVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //상단 좋아요, 댓글 LBL
    @IBOutlet weak var likeCountLbl: UILabel!
    @IBOutlet weak var commentCountLbl: UILabel!
    
    
    @IBOutlet weak var navView: UIView!
    
    //tableView
    @IBOutlet weak var CommentTableView: UITableView!
    
    //취소버튼
    @IBAction func dissmissBtn(_ sender: Any) {
        
    }
    
    @IBOutlet weak var commentWriteBar: UIView!
    @IBOutlet weak var commentWriteField: UITextField!
    //댓글 저장Btn
    @IBOutlet weak var commentSendBtn: UIButton!
    
//    var clicked: Bool = false
//   @objc func isClicked(_ sender: UIButton) {
//        if clicked == false { //
//            commentLikeBtn.setImage(#imageLiteral(resourceName: "content_smallheart_blackbackground"), for: .normal)
//            //cell에 있는 likeCount늘어나야함
//        }else {
//            clicked = true
//            commentLikeBtn.setImage(#imageLiteral(resourceName: "content_smallheart_whitebackground"), for: .normal)
//        }
//    }
    
   
    
    
    var keyboardDismissGesture: UITapGestureRecognizer?
    ////////////////샘플데이터//////////////////////
    var data = CommentData.sharedInstance.comments
    ////////////////////////////////////
    //--------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        CommentTableView.delegate = self
        CommentTableView.dataSource = self
        //comment의 댓글 글자수 제한
        commentWriteField.addTarget(self, action: #selector(canCommentSend), for: .editingChanged)
        setKeyboardSetting()
        //statusBar 없애기
        hideStatusBar = true
        setNeedsStatusBarAppearanceUpdate()
     
        commentWriteBar.snp.makeConstraints { (make) in
            make.width.equalTo(self.view.frame.width)
            make.height.equalTo(56)
            make.bottom.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
      
        
        CommentTableView.snp.makeConstraints { (make) in
            make.top.equalTo(navView.snp.bottom)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            //make.height.equalTo(100)
            make.bottom.equalTo(commentWriteBar.snp.top)
        }
        self.view.bringSubview(toFront: commentWriteBar)
        
    }
    private var hideStatusBar: Bool = false
    
    override var prefersStatusBarHidden: Bool {
        return hideStatusBar
    }
    //comment댓글 글자 수 제한
    @objc func canCommentSend() {
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //----------------tableView---------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //다시!!!!!!!!!!!!!!!!!!!!!1
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
        cell.configure(data: data[indexPath.row])
        //cell.commentLikeBtn.setImage(#imageLiteral(resourceName: "content_smallheart_blackbackground"), for: .normal)
        cell.commentLikeBtn.addTarget(self, action: #selector(self.likeBtnClicked(sender:)), for: .touchUpInside)
        cell.recommentBtn.tag = indexPath.row;
        cell.recommentBtn.isUserInteractionEnabled = true
        cell.recommentBtn.isEnabled = true
        cell.recommentBtn.tintColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        cell.recommentBtn.addTarget(self, action: #selector(self.goRecomment(sender:)), for: .touchUpInside)
        //        cell.recommentCountLbl.text = comments[indexPath.row].commentCount
        return cell
    }
    
    //var clicked: Bool = false
    var beforeClickHeart: UIImage = UIImage(named: "content_smallheart_whitebackground")!
    //content_smallheart_whitebackground
    var afterClickHeart: UIImage = UIImage(named: "content_smallheart_blackbackground")!
    //content_smallheart_blackbackground
    @objc func likeBtnClicked(sender: UIButton) {
        //하트이미지 바뀌고
        
        //likeCountLbl +1 그리고 해당commentIdx의 likeCount 수 올려야 됨->
        
    }
    
    @objc func goRecomment(sender : UIButton){
        
        // Your code here
        let userId = data[sender.tag].userId
        let recommentVC = UIStoryboard(name: "Sub", bundle: nil).instantiateViewController(withIdentifier: "RecommentVC") as! RecommentVC
        self.navigationController?.pushViewController(recommentVC, animated: true)
        //다른 뷰로 넘길때 userId 같이 넘기면 (나중에는 댓글에 대한 고유 인덱스가 됨) 그거 가지고 다시 통신
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

            var contentInset = self.CommentTableView.contentInset
            contentInset.bottom = keyboardSize.height
            CommentTableView.contentInset = contentInset
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
     
            var contentInset = self.CommentTableView.contentInset
            contentInset.bottom = 0
            CommentTableView.contentInset = contentInset
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
