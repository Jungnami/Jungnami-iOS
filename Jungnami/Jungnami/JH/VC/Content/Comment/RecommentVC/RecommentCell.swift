//
//  RecommentCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 3..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class RecommentCell: UITableViewCell {

    
    @IBOutlet weak var recommentProfilImg: UIImageView!
    @IBOutlet weak var recommentUserLbl: UILabel!
    @IBOutlet weak var recommentContentLbl: UILabel!
    @IBOutlet weak var recommentDateLbl: UILabel!
    @IBOutlet weak var recommentLikeCountLbl: UILabel!
    //누르면 댓글입력창에 유저아이디/닉네임 굵은 글씨로 나오고, tableviewReload
    @IBOutlet weak var recommentRecommentBtn: UIButton!
    
    //데이터 통신할 때 짧게 쓰기위해 씀!
    func configure(data: RecommentSample) {
        recommentProfilImg.image = data.profileImg
        recommentUserLbl.text = data.userId
        recommentContentLbl.text = data.recommentContent
        recommentDateLbl.text = data.date
        recommentLikeCountLbl.text = data.likeCount
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        recommentProfilImg.layer.masksToBounds = true
        recommentProfilImg.layer.cornerRadius = recommentProfilImg.layer.frame.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
