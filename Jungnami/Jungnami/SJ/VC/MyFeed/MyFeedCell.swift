//
//  MyFeedCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 12..
//

import UIKit
import Kingfisher

class MyFeedCell: UITableViewCell {

    @IBOutlet weak var userImgView: UIImageView! //
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
     @IBOutlet weak var contentImgView: UIImageView! //
      @IBOutlet weak var likeCntLbl: UILabel!
      @IBOutlet weak var commentCntLbl: UILabel!
      @IBOutlet weak var likeBtn: myHeartBtn!
     @IBOutlet weak var commentBtn: myCommentBtn!
    
    func configure(data : MyPageVODataBoard){
        if (gsno(data.uImg) == "0") {
            userImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
        } else {
            if let url = URL(string: gsno(data.uImg)){
                self.userImgView.kf.setImage(with: url)
            }
        }
        
        if (gsno(data.bImg) == "0") {
            contentImgView.image = #imageLiteral(resourceName: "dabi")
        } else {
            if let url = URL(string: gsno(data.bImg)){
                self.contentImgView.kf.setImage(with: url)
            }
        }
        
        userNameLbl.text = data.uNickname
        dateLbl.text = data.bTime
        contentLbl.text = data.bContent
        contentLbl.sizeToFit()
        likeCntLbl.text = "\(data.likeCnt)"
        commentCntLbl.text = "\(data.commentCnt)"
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        userImgView.makeImageRound()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
