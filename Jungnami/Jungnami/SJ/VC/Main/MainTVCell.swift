//
//  MainTVCell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 6..
//

import UIKit
import Kingfisher

class LikeButton : UIButton {
    var index : Int = 0
    var row : Int = 0
}

class MainTVCell: UITableViewCell {
    
    @IBOutlet weak var rankLbl: UILabel!
    @IBOutlet weak var medalImgView: UIImageView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var partyLbl: UILabel!
    @IBOutlet weak var voteCountLbl: UILabel!
    @IBOutlet weak var voteBtn: LikeButton!
  
    let maxWidth : Double = 240.0
    func configure(viewType : MainViewType, row : Int, data : Legislator){
        
        voteBtn.index = data.idx
        voteBtn.row = row
        
        if let profileImg = data.profileImg, let imgUrl = URL(string : profileImg) {
             self.profileImgView.kf.setImage(with: imgUrl)
             profileImgView.contentMode = .scaleAspectFill
        } else {
            profileImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
        }
        
        nameLbl.text = data.legiName+"_"
        partyLbl.text = data.partyCD?.partyName
        voteCountLbl.text = (data.voteCnt ?? 0).description + "표"
        
        profileImgView.makeImageRound()
    
        progressBar.snp.makeConstraints { (make) in
            
            if maxWidth*(data.ratio ?? 0.0)/100 < 18 {
                 make.width.equalTo(18)
            } else {
                make.width.equalTo(maxWidth*(data.ratio ?? 00)/100)
            }
    
            make.height.equalTo(12)
            make.leading.equalTo(profileImgView.snp.trailing).offset(-15)
            make.bottom.equalTo(profileImgView.snp.bottom).offset(-7)
            make.top.equalTo(nameLbl.snp.bottom).offset(3)
        }
        progressBar.makeRounded()
        
        let rank = data.rank
        rankLbl.text = rank
        switch viewType {
        case .like:
            if rank == "1" {
                setMedalImg(image: #imageLiteral(resourceName: "ranking_gold_medal"))
            } else if rank == "2" {
                setMedalImg(image: #imageLiteral(resourceName: "ranking_silver_medal"))
            } else if rank == "3" {
                setMedalImg(image: #imageLiteral(resourceName: "ranking_bronze_medal"))
            } else {
               medalImgView.isHidden = true
            }
        case .dislike :
            if rank == "1" {
                setMedalImg(image: #imageLiteral(resourceName: "ranking_red_bomb"))
            } else if rank == "2" {
                setMedalImg(image: #imageLiteral(resourceName: "ranking_orange_bomb"))
            } else if rank == "3" {
                setMedalImg(image: #imageLiteral(resourceName: "ranking_yellow_bomb"))
            } else {
                medalImgView.isHidden = true
            }
        }
        
        if(row % 2 == 1){
            self.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9843137255, alpha: 1)
        } else {
            self.backgroundColor = .white
        }
    }
    
    func setMedalImg(image : UIImage){
        medalImgView.image = image
        medalImgView.isHidden = false
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        progressBar.deactivateAllConstraints()
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImgView.layer.borderColor = ColorChip.shared().mainColor.cgColor
        profileImgView.layer.borderWidth = 2
    }
}

