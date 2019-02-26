//
//  LegislatorProfileCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 7..
//

import UIKit

class LegislatorProfileCell: UICollectionViewCell {
   
    @IBOutlet weak var medalImgView: UIImageView!
    @IBOutlet weak var bombImgView: UIImageView!
    @IBOutlet weak var legislatorProfileImgView: UIImageView!
    @IBOutlet weak var legislatorNameLbl: UILabel!
    @IBOutlet weak var legislatorLikeLbl: UILabel!
    @IBOutlet weak var legislatorDislikeLbl: UILabel!
    @IBOutlet weak var legislatorPartyLbl: UILabel!
    @IBOutlet weak var legislatorRegionLbl: UILabel!
    @IBOutlet weak var reelectionLbl: UILabel!
    @IBOutlet weak var ordinalLbl: UILabel!
    @IBOutlet weak var crimeLbl: UILabel!
    @IBOutlet weak var fbLbl: UILabel!
    @IBOutlet weak var twitterLbl: UILabel!
    @IBOutlet weak var blogLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var dislikeBtn: UIButton!
    @IBOutlet weak var voteBtn: UIButton!
 
    func configure(data: LegislatorDetail) {
        if let profileImg = data.profileImg, let url = URL(string : profileImg) {
             self.legislatorProfileImgView.kf.setImage(with: url)
        } else {
            legislatorProfileImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
        }
        legislatorNameLbl.text = data.legiName
        legislatorPartyLbl.text = data.partyCD?.partyName
        legislatorRegionLbl.text = data.region
        reelectionLbl.text = (data.reelection ?? "") + "의원"
        ordinalLbl.text = (data.ordinal ?? 0).description + "대"
        crimeLbl.text = data.crime != nil ? data.crime : "없음"
        fbLbl.text = data.facebook != "" ? data.facebook : "없음"
        twitterLbl.text = data.twitter != "" ? data.twitter : "없음"
        blogLbl.text = data.blog != "" ? data.blog : "없음"
        phoneLbl.text = data.phone != "" ? data.phone : "없음"
        
        legislatorLikeLbl.text = "호감 \(data.likeRank ?? "")위"
        legislatorDislikeLbl.text = "비호감 \(data.dislkeRank ?? "")위"
        
        legislatorProfileImgView.makeImgBorder(width: 3, color: data.partyCD?.partyColor ?? .black)
        
        switch (data.likeRank ?? ""){
        case "1":
            medalImgView.image = #imageLiteral(resourceName: "legislator-detailpage_medal_gold")
            medalImgView.isHidden = false
        case "2":
            medalImgView.image = #imageLiteral(resourceName: "legislator-detailpage_medal_silver")
            medalImgView.isHidden = false
        case "3":
            medalImgView.image = #imageLiteral(resourceName: "legislator-detailpage_medal_bronze")
            medalImgView.isHidden = false
        default:
            medalImgView.deactivateAllConstraints()
            medalImgView.isHidden = true
        }
        switch (data.dislkeRank ?? "") {
        case "1":
            bombImgView.image = #imageLiteral(resourceName: "legislator-detailpage_red_bomb")
             bombImgView.isHidden = false
        case "2":
            bombImgView.image = #imageLiteral(resourceName: "legislator-detailpage_orange_bomb")
             bombImgView.isHidden = false
        case "3":
            bombImgView.image = #imageLiteral(resourceName: "legislator-detailpage_yellow_bomb")
             bombImgView.isHidden = false
        default :
            bombImgView.isHidden = true
        }
      
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        legislatorProfileImgView.makeImageRound()
        
    }
}


