//
//  MainTVCell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 6..
//

import UIKit
import Kingfisher

class MainTVCell: UITableViewCell {
    
    @IBOutlet weak var rankLbl: UILabel!
    @IBOutlet weak var medalImgView: UIImageView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var progressBar: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var partyLbl: UILabel!
    @IBOutlet weak var voteCountLbl: UILabel!
    @IBOutlet weak var voteBtn: UIButton!
    
    let maxWidth : Double = 240.0
    func configure(viewType : MainViewType, index : Int, data : LegislatorLikeVOData){
        
        if (gsno(data.profileimg) == "0") {
            profileImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
        } else {
            if let url = URL(string: gsno(data.profileimg)){
                self.profileImgView.kf.setImage(with: url)
            }
        }
        nameLbl.text = data.lName
        partyLbl.text = "_\(data.partyName.rawValue)"
        voteCountLbl.text = "\(String(describing: data.scoretext))"
        
        profileImgView.makeImageRound()
    
        progressBar.snp.makeConstraints { (make) in
            make.width.equalTo(maxWidth*data.width)
           // make.width.equalTo(240)
            make.height.equalTo(12)
            make.leading.equalTo(profileImgView.snp.trailing).offset(-15)
            make.bottom.equalTo(profileImgView.snp.bottom).offset(-7)
            make.top.equalTo(nameLbl.snp.bottom).offset(3)
        }
        progressBar.makeRounded()
        
        switch viewType {
        case .like:
            rankLbl.text = data.ranking
            if data.ranking == "1" {
                medalImgView.image = #imageLiteral(resourceName: "ranking_gold_medal")
            } else if data.ranking == "2" {
                medalImgView.image = #imageLiteral(resourceName: "ranking_silver_medal")
            } else if data.ranking == "3" {
                medalImgView.image = #imageLiteral(resourceName: "ranking_bronze_medal")
            }
        case .dislike :
            rankLbl.text =  data.ranking
            if data.ranking == "1" {
                medalImgView.image = #imageLiteral(resourceName: "ranking_red_bomb")
            } else if data.ranking == "2" {
                medalImgView.image = #imageLiteral(resourceName: "ranking_orange_bomb")
            } else if data.ranking == "3" {
                medalImgView.image = #imageLiteral(resourceName: "ranking_yellow_bomb")
            }

        }

        
        if index > 2 {
            medalImgView.isHidden = true
        }
        
        if(index % 2 == 1){
            self.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9843137255, alpha: 1)
        } else {
            self.backgroundColor = .white
        }
        
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImgView.layer.borderColor = ColorChip.shared().mainColor.cgColor
        profileImgView.layer.borderWidth = 2
   
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }
    
}

