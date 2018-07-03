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
    
    
    @IBOutlet weak var commentBestImg: UIImageView!
    //댓글 좋아요 Btn
    @IBOutlet weak var commentLikeBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commentProfileImg.layer.masksToBounds = true
        commentProfileImg.layer.cornerRadius = commentProfileImg.layer.frame.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
