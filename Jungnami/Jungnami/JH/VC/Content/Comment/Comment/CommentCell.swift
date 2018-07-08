//
//  CommentCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 3..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    //comment
    @IBOutlet weak var commentProfileImg: UIImageView!
    @IBOutlet weak var commentUserLbl: UILabel!
    @IBOutlet weak var commentContentLbl: UILabel!
    @IBOutlet weak var commentDateLbl: UILabel!
    @IBOutlet weak var commentLikeLbl: UILabel!
   
     @IBOutlet weak var recommentBtn: UIButton!
 
    @IBOutlet weak var commentBestImg: UIImageView!
    //댓글 좋아요 Btn
    @IBOutlet weak var commentLikeBtn: UIButton!
    
    var delegate : TapDelegate?
    var index = 0
    func configure(data : CommentSample){
        commentProfileImg.image = data.profile
        commentUserLbl.text = data.userId
        commentContentLbl.text = data.commentContent
        commentDateLbl.text = data.date
        commentLikeLbl.text = data.likeCount
        index = 12 //나중에 유저 인덱스 등으로 고칠 수 있음
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commentProfileImg.layer.masksToBounds = true
        commentProfileImg.layer.cornerRadius = commentProfileImg.layer.frame.width/2
        
        //탭제스처 레코그나이저
        commentProfileImg.isUserInteractionEnabled = true
        commentUserLbl.isUserInteractionEnabled = true
        
        let imgTapGesture = UITapGestureRecognizer(target: self, action: #selector(CommentCell.imgTap(sender:)))
        let lblTapGesture = UITapGestureRecognizer(target: self, action: #selector(CommentCell.lblTap(sender:)))
        self.commentUserLbl.addGestureRecognizer(lblTapGesture)
        self.commentProfileImg.addGestureRecognizer(imgTapGesture)
    }

    @objc func imgTap(sender: UITapGestureRecognizer) {
        delegate?.myTableDelegate(index : index)
    }
    @objc func lblTap(sender: UITapGestureRecognizer) {
        delegate?.myTableDelegate(index : index)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
