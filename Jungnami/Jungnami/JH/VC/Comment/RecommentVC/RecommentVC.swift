//
//  RecommentVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 3..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit
import SnapKit

class RecommentVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var navView: UIView!
    //tableView
    @IBOutlet weak var RecommentTableView: UITableView!
    //commentBar
    @IBOutlet weak var writeRecommentBar: UIView!
    @IBOutlet weak var wirteRecommentField: UITextField!
    //fieldImgView
    @IBOutlet weak var grayBar: UIImageView!
    //comment 전송버튼
    @IBOutlet weak var sendRecommentBtn: UIButton!
    
    //tapGesture
    var keyboardDismissGesture: UITapGestureRecognizer?
    
    //댓글로 돌아가기 버튼
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    ///////샘플데이터////////////
    var recommentData = RecommentData.sharedInstance.recomments
    var commentData : [CommunityCommentVOData] = []
    ///////////////////////////
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        RecommentTableView.delegate = self
        RecommentTableView.dataSource = self
        
        hideStatusBar = true
        setNeedsStatusBarAppearanceUpdate()
        
        wirteRecommentField.addTarget(self, action: #selector(canCommentSend), for: .editingChanged)
        setKeyboardSetting()
        RecommentTableView.tableFooterView = UIView()
        //레이아웃 맞추는 것
        writeRecommentBar.snp.makeConstraints { (make) in
            
            make.width.equalTo(self.view.frame.width)
            
            make.height.equalTo(56)
            make.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
            
        }
        
        
        writeRecommentBar.addSubview(sendRecommentBtn)
        writeRecommentBar.addSubview(grayBar)
        writeRecommentBar.addSubview(wirteRecommentField)
        
        grayBar.snp.makeConstraints { (make) in
            make.leading.equalTo(writeRecommentBar).offset(12)
            make.centerY.equalTo(writeRecommentBar)
            make.width.equalTo(302)
            
        }
        
        wirteRecommentField.snp.makeConstraints { (make) in
            make.top.bottom.trailing.equalTo(grayBar)
            make.leading.equalTo(grayBar).offset(10)
        }
        sendRecommentBtn.snp.makeConstraints { (make) in
            make.leading.equalTo(grayBar.snp.trailing).offset(8)
            make.centerY.equalTo(grayBar)
            make.width.height.equalTo(42)
            
        }
        
        
        RecommentTableView.snp.makeConstraints { (make) in
            make.top.equalTo(navView.snp.bottom)
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            //make.height.equalTo(100)
            make.bottom.equalTo(writeRecommentBar.snp.top)
        }
        self.view.bringSubview(toFront: writeRecommentBar)
        
        ///////////샘플데이터/////////////////
        
    }
    //statusHide
    private var hideStatusBar: Bool = false
    
    override var prefersStatusBarHidden: Bool {
        return hideStatusBar
    }
    //commentField에서 send버튼 활성화
    @objc func canCommentSend() {
        if wirteRecommentField.text?.count == 0 { //입력안됐을때
            //버튼 활성화 안되고 유저 인터렉션 불가
            sendRecommentBtn.isUserInteractionEnabled = false
            sendRecommentBtn.isEnabled = false
        } else if ((wirteRecommentField.text?.count)! < 100){
            //버튼 활성화 되고 유저 인터렉션 가능
            sendRecommentBtn.isUserInteractionEnabled = true
            //버튼 활성화, 이미지 색 바꾸기
            sendRecommentBtn.tintColor = #colorLiteral(red: 0.2117647059, green: 0.7725490196, blue: 0.9450980392, alpha: 1)
            sendRecommentBtn.isEnabled = true
        } else {
            guard let commentTxt = wirteRecommentField.text else {return}
            simpleAlert(title: "오류", message: "100글자 초과")
            wirteRecommentField.text = String(describing: commentTxt.prefix(99))
            //버튼 활성화 되고 유저 인터렉션 가능
            sendRecommentBtn.isUserInteractionEnabled = true
            //버튼 활성화, 이미지 색 바꾸기
            sendRecommentBtn.tintColor = #colorLiteral(red: 0.2117647059, green: 0.7725490196, blue: 0.9450980392, alpha: 1)
            sendRecommentBtn.isEnabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //-------------tablView---------------
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            //데이터 연결하면 recomment.count 로 바꾸기!
            print(recommentData.count)
            return recommentData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            //cell정보들에 연결하기
            //cell.delegate = self
            cell.configure(index : indexPath.row, data: commentData[indexPath.row])
            return cell
        }else {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "RecommentCell", for: indexPath) as! RecommentCell
            //cell에 연결된 정보 연결하기
            cell.delegate = self
            cell.configure(data: recommentData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
            
            return cell
        }
    }
}


extension RecommentVC {
    
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
            
            var contentInset = self.RecommentTableView.contentInset
            contentInset.bottom = keyboardSize.height
            RecommentTableView.contentInset = contentInset
            
            writeRecommentBar.frame.origin.y -= keyboardSize.height
            ////////
            self.view.layoutIfNeeded()
            
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            //////// 키보드의 사이즈만큼 commentSendView의 y축을 아래로 이동시킴 ////////
            
            var contentInset = self.RecommentTableView.contentInset
            contentInset.bottom = 0
            RecommentTableView.contentInset = contentInset
            writeRecommentBar.frame.origin.y += keyboardSize.height
            
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
extension RecommentVC : TapDelegate, UIGestureRecognizerDelegate {
    func myTableDelegate(index: Int) {
        print(index)
    }
}
