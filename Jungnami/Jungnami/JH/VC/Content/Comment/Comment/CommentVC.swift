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
    @IBAction func commentSendBtn(_ sender: Any) {
        
    }
    
    //---------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        CommentTableView.delegate = self
        CommentTableView.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //----------------tableView---------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //다시!!!!!!!!!!!!!!!!!!!!!1
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UIStoryboard(name: "Sub", bundle: nil).instantiateViewController(withIdentifier: "CommentCell") as! CommentCell
        //다시
        return cell
    }
   
}
