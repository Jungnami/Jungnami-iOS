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
    @IBOutlet weak var writeCommentField: UIImageView!
        //comment 전송버튼
    @IBAction func sendCommentBar(_ sender: Any) {
        //전송!
    }
    
    
    //댓글로 돌아가기 버튼
    @IBAction func backBtn(_ sender: Any) {
        //pop으로 화면전환
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RecommentTableView.delegate = self
        RecommentTableView.dataSource = self

        // Do any additional setup after loading the view.
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
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
            //cell정보들에 연결하기
            /*
             cell.commentProfileImg.image =
             cell.commentBestImg.image
             cell.commentContentLbl.text =
             cell.commentDateLbl.text =
             cell.commentLikeBtn.text =
             */
            return cell
        }else {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "RecommentCell", for: indexPath) as! RecommentCell
            //cell에 연결된 정보 연결하기
            return cell
        }
    }
}
