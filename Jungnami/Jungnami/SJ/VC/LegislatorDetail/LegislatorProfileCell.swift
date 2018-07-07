//
//  LegislatorProfileCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 7..
//

import UIKit

class LegislatorProfileCell: UICollectionViewCell {
   
    @IBOutlet weak var medalImgView: UIImageView!
    @IBOutlet weak var legislatorProfileImgView: UIImageView!
    @IBOutlet weak var legislatorNameLbl: UILabel!
    @IBOutlet weak var legislatorLikeLbl: UILabel!
    @IBOutlet weak var legislatorDislikeLbl: UILabel!
    @IBOutlet weak var legislatorPartyLbl: UILabel!
    @IBOutlet weak var legislatorRegionLbl: UILabel!
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var dislikeBtn: UIButton!
    @IBOutlet weak var voteBtn: UIButton!
    
    
    func configure(data: SampleLegislator) {
        legislatorProfileImgView.image = data.profile
        legislatorNameLbl.text = data.name
        legislatorPartyLbl.text = data.party.rawValue
        legislatorRegionLbl.text = data.region
        legislatorLikeLbl.text = "\(data.likeCount)"
        legislatorDislikeLbl.text = "\(data.dislikeCount)"
        
        switch data.party {
        case .blue:
             legislatorProfileImgView.makeImgBorder(width: 3, color: ColorChip.shared().partyBlue)
        case .red:
            legislatorProfileImgView.makeImgBorder(width: 3, color: ColorChip.shared().partyRed)
        case .orange:
            legislatorProfileImgView.makeImgBorder(width: 3, color: ColorChip.shared().partyOrange)
        case .mint:
            legislatorProfileImgView.makeImgBorder(width: 3, color: ColorChip.shared().partyMint)
        case .yellow:
            legislatorProfileImgView.makeImgBorder(width: 3, color: ColorChip.shared().partyYellow)
       
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        legislatorProfileImgView.makeImageRound()
        
    }
}
