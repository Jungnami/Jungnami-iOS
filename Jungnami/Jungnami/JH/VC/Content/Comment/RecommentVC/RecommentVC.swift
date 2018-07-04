//
//  RecommentVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 3..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class RecommentVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    //tableView
    @IBOutlet weak var RecommentTableView: UITableView!
    //commentBar
    @IBOutlet weak var writeRecommentBar: UIView!
    @IBOutlet weak var wirteRecommentField: UITextField!
    //comment 전송버튼
    @IBOutlet weak var sendRecommentBtn: UIButton!
    
    
    
    //댓글로 돌아가기 버튼
    @IBAction func backBtn(_ sender: Any) {
        //pop으로 화면전환
        let backVC = UIStoryboard(name: "Sub", bundle: nil).instantiateViewController(withIdentifier: "CommentVC") as! CommentVC
        self.navigationController?.popViewController(animated: false)
    }
    ///////샘플데이터////////////
    var recommentData = RecommentData.sharedInstance.recomments
    var commentData = CommentData.sharedInstance.comments
    ///////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        RecommentTableView.delegate = self
        RecommentTableView.dataSource = self
        
        hideStatusBar = true
        setNeedsStatusBarAppearanceUpdate()
        
        wirteRecommentField.addTarget(self, action: #selector(canCommentSend), for: .editingChanged)
        
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
            cell.configure(data: commentData[indexPath.row])
            return cell
        }else {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "RecommentCell", for: indexPath) as! RecommentCell
            //cell에 연결된 정보 연결하기
            
            cell.configure(data: recommentData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
            
            return cell
        }
    }
}
