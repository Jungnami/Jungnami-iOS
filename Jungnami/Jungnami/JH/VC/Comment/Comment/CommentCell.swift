//
//  CommentCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 3..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit
import Kingfisher

class myTouchLbl : UILabel {
    var userId : String = ""
}

class myTouchImg  : UIImageView {
    var userId : String = ""
}

class CommentCell: UITableViewCell {

    
    //comment
    @IBOutlet weak var commentProfileImg: myTouchImg!
    @IBOutlet weak var commentUserLbl: myTouchLbl!
    @IBOutlet weak var commentContentLbl: UILabel!
    @IBOutlet weak var commentDateLbl: UILabel!
    @IBOutlet weak var commentLikeLbl: UILabel!
   
     @IBOutlet weak var recommentBtn: UIButton!
 
    @IBOutlet weak var commentBestImg: UIImageView!
    //댓글 좋아요 Btn
    @IBOutlet weak var commentLikeBtn: myHeartBtn!
    //---------tapGesture--------
    var delegate : TapDelegate2?
    var index = 0
    //----------------------------
    func configure(index : Int, data : CommunityCommentVOData){
      
        if (gsno(data.userImg) == "0") {
            commentProfileImg.image = #imageLiteral(resourceName: "mypage_profile_girl")
        } else {
            if let url = URL(string: gsno(data.userImg)){
                self.commentProfileImg.kf.setImage(with: url)
            }
        }
        commentLikeBtn.setImage(UIImage(named: "community_heart"), for: .normal)
        commentLikeBtn.setImage(UIImage(named: "community_heart_blue"), for: .selected)
        commentUserLbl.text = data.userNick
        commentContentLbl.text = data.content
        commentContentLbl.sizeToFit()
        commentDateLbl.text = data.timeset
        commentLikeLbl.text = "\(data.commentlikeCnt)"
        
        commentLikeBtn.indexPath = index
        commentLikeBtn.boardIdx = data.commentid
        commentLikeBtn.isLike = data.islike
        if data.islike == 0 {
            commentLikeBtn.isSelected = false
        } else {
            commentLikeBtn.isSelected = true
        }
        
        
        if index < 3 {
            commentBestImg.isHidden = false
        } else {
            commentBestImg.isHidden = true
        }
        
        
      //  index = 12 //나중에 유저 인덱스 등으로 고칠 수 있음
        commentUserLbl.userId = data.userId
        commentProfileImg.userId = data.userId
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commentProfileImg.layer.masksToBounds = true
        commentProfileImg.layer.cornerRadius = commentProfileImg.layer.frame.width/2
        
        //------------tapGesture--------------------------
        commentProfileImg.isUserInteractionEnabled = true
        commentUserLbl.isUserInteractionEnabled = true
        
        let imgTapGesture = UITapGestureRecognizer(target: self, action: #selector(CommentCell.imgTap(sender:)))
        let lblTapGesture = UITapGestureRecognizer(target: self, action: #selector(CommentCell.lblTap(sender:)))
        self.commentUserLbl.addGestureRecognizer(lblTapGesture)
        self.commentProfileImg.addGestureRecognizer(imgTapGesture)
    }

    @objc func imgTap(sender: UITapGestureRecognizer) {
        delegate?.myTableDelegate(sender: sender)
    }
    @objc func lblTap(sender: UITapGestureRecognizer) {
        delegate?.myTableDelegate(sender : sender)
    }
    //-----------------------------------------------
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
