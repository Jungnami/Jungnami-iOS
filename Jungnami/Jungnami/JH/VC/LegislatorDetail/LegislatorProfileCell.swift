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
    //호감투표버튼
    @IBAction func legislatorLikeVoteBtn(_ sender: Any) {
    }
    //비호감투표버튼
    @IBAction func legislatorDialikeBtn(_ sender: Any) {
    }
    //후원하기버튼
    @IBAction func legislatorSupportBtn(_ sender: Any) {
    }
    
    var data = LegislatorData.sharedInstance.legislators
    func configure(data: LegislatorSample) {
       // self.legislatorProfileImgView.layer.cornerRadius = self.legislatorProfileImgView.layer.frame.size.width / 2
        //legislatorProfileImgView.backgroundColor = .red
        legislatorProfileImgView.image = data.profileImg
        legislatorNameLbl.text = data.name
        legislatorPartyLbl.text = data.party
        legislatorRegionLbl.text = data.region
        legislatorLikeLbl.text = data.likeRank
        legislatorDislikeLbl.text = data.dislikeRank
        
    }
}
