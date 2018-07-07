//
//  LegislatorProfileCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 7..
//

import UIKit

class LegislatorProfileCell: UICollectionViewCell {
    
    @IBOutlet weak var legislatorProfileImgView: UIImageView!
    @IBOutlet weak var legislatorNameLbl: UILabel!
    @IBOutlet weak var legislatorLikeLbl: UILabel!
    @IBOutlet weak var legislatorDislikeLbl: UILabel!
    @IBOutlet weak var legislatorPartyLbl: UILabel!
    @IBOutlet weak var legislatorRegionLbl: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var dislikeBtn: UIButton!
    @IBOutlet weak var voteBtn: UIButton!
    //호감투표버튼
    @IBAction func legislatorLikeVoteBtn(_ sender: Any) {
        //likeBtn.setImage(#imageLiteral(resourceName: "legislator-detailpage_like_blue"), for: .selected)
    }
    
    //비호감투표버튼
    @IBAction func legislatorDialikeBtn(_ sender: Any) {
        //dislikeBtn.setImage(#imageLiteral(resourceName: "legislator-detailpage_hate_blue"), for: .selected)
    }
    //후원하기버튼
    @IBAction func legislatorSupportBtn(_ sender: Any) {
        //voteBtn.setImage(#imageLiteral(resourceName: "legislator-detailpage_support_blue"), for: .selected)
    }
    
    var data = LegislatorData.sharedInstance.legislators
    func configure(data: LegislatorSample) {
        legislatorProfileImgView.image = data.profileImg
        legislatorNameLbl.text = data.name
        legislatorPartyLbl.text = data.party
        legislatorRegionLbl.text = data.region
        legislatorLikeLbl.text = data.likeRank
        legislatorDislikeLbl.text = data.dislikeRank
        
    }
}
