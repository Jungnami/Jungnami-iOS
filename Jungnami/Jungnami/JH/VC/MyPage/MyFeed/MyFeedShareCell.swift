//
//  MyFeedShareCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 12..
//

import UIKit
import Kingfisher

class MyFeedShareCell: UITableViewCell {

    @IBOutlet weak var grayBackground: UIView!
    
    @IBOutlet weak var whiteBackground: UIView!
    
    @IBOutlet weak var sharedBG: UIView!
    
    @IBOutlet weak var sharedProfileImgView: UIImageView!
    
    @IBOutlet weak var sharedContentLbl: UILabel!
    
    @IBOutlet weak var sharedContentImgView: UIImageView!
    
    @IBOutlet weak var sharedTimeLbl: UILabel!
    @IBOutlet weak var sharedNameLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
     @IBOutlet weak var userProfileImg: UIImageView!
    
    @IBOutlet weak var likeCntLbl: UILabel!
    @IBOutlet weak var chatCntLbl: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    
   
    func configure(data : MyPageVODataBoard) {
        if (gsno(data.uImg) == "0") {
            userProfileImg.image = #imageLiteral(resourceName: "mypage_profile_girl")
        } else {
            if let url = URL(string: gsno(data.uImg)){
                self.userProfileImg.kf.setImage(with: url)
            }
        }
        
        if (gsno(data.source[0].uImg) == "0") {
            sharedProfileImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
        } else {
            if let url = URL(string: gsno(data.source[0].uImg)){
                self.sharedProfileImgView.kf.setImage(with: url)
            }
        }
        
        if (gsno(data.source[0].bImg) == "0") {
            sharedContentImgView.image = #imageLiteral(resourceName: "dabi")
        } else {
            if let url = URL(string: gsno(data.source[0].bImg)){
                self.sharedContentImgView.kf.setImage(with: url)
            }
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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
