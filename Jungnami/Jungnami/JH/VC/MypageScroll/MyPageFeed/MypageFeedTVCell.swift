//
//  MypageFeedTVCell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 8. 6..
//

import UIKit

class MypageFeedTVCell: UITableViewCell {

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
        if (gsno(data.uImg) == "") {
            userImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
        } else {
            if let url = URL(string: gsno(data.uImg)){
                self.userImgView.kf.setImage(with: url)
            }
        }
        
        if (gsno(data.bImg) == "0") {
            contentImgView.image = #imageLiteral(resourceName: "community_default_img")
        } else {
            if let url = URL(string: gsno(data.bImg)){
                self.contentImgView.kf.setImage(with: url)
            }
        }
        
        
        
        
        
        commentBtn.tag = (data.bID)
        commentBtn.likeCnt = data.likeCnt
        commentBtn.commentCnt = data.commentCnt
        
        likeBtn.setImage(UIImage(named: "community_heart"), for: .normal)
        likeBtn.setImage(UIImage(named: "community_heart_blue"), for: .selected)
        likeBtn.likeCnt = data.likeCnt
        likeBtn.boardIdx = data.bID
        likeBtn.isLike = data.islike
        likeBtn.cellFrom = 1
        
        if data.islike == 0 {
            likeBtn.isSelected = false
        } else {
            likeBtn.isSelected = true
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
        self.selectionStyle = .none
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
}
