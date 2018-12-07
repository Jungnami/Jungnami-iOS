//
//  MypageNoImageFeedScrapTVCell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 8. 9..
//

import UIKit

class MypageNoImageFeedScrapTVCell: UITableViewCell {

    @IBOutlet weak var grayBackground: UIView!
    
    @IBOutlet weak var whiteBackground: UIView!
    
    @IBOutlet weak var sharedBG: UIView!
    
    @IBOutlet weak var sharedProfileImgView: UIImageView!
    
    @IBOutlet weak var sharedContentLbl: UILabel!
    
    @IBOutlet weak var sharedTimeLbl: UILabel!
    @IBOutlet weak var sharedNameLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var userProfileImg: UIImageView!
    
    @IBOutlet weak var likeCntLbl: UILabel!
    @IBOutlet weak var chatCntLbl: UILabel!
    
    @IBOutlet weak var likeBtn: myHeartBtn!
    @IBOutlet weak var commentBtn: myCommentBtn!
    
    
    func configure(data : MyPageVODataBoard) {
        if (gsno(data.uImg) == "") {
            userProfileImg.image = #imageLiteral(resourceName: "mypage_profile_girl")
        } else {
            if let url = URL(string: gsno(data.uImg)){
                self.userProfileImg.kf.setImage(with: url)
            }
        }
        
        if (gsno(data.source[0].uImg) == "") {
            sharedProfileImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
        } else {
            if let url = URL(string: gsno(data.source[0].uImg)){
                self.sharedProfileImgView.kf.setImage(with: url)
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
        likeBtn.cellFrom = 0
        
        if data.islike == 0 {
            likeBtn.isSelected = false
        } else {
            likeBtn.isSelected = true
        }
        
        
        userNameLbl.text = data.uNickname
        dateLbl.text = data.bTime
        
        
        likeCntLbl.text = "\(data.likeCnt)"
        chatCntLbl.text = "\(data.commentCnt)"
        sharedContentLbl.text = "\(data.source[0].bContent)"
        sharedTimeLbl.text = "\(data.source[0].bTime)"
        sharedNameLbl.text = "\(data.source[0].uNickname)"
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sharedBG.layer.borderWidth = 1
        sharedBG.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        sharedProfileImgView.makeImageRound()
        userProfileImg.makeImageRound()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
