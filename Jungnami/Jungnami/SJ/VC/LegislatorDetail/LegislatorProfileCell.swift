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
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var dislikeBtn: UIButton!
    @IBOutlet weak var voteBtn: UIButton!
 
    func configure(data: LegislatorDetailVOData) {
        legislatorProfileImgView.image = #imageLiteral(resourceName: "dabi")
        legislatorNameLbl.text = data.lName
        legislatorPartyLbl.text = data.partyName.rawValue
        legislatorRegionLbl.text = data.position
        
        legislatorLikeLbl.text = "호감 \(data.likerank)위"
        legislatorDislikeLbl.text = "비호감 \(data.unlikerank)위"
        switch data.likerank {
        case "1":
            medalImgView.image = #imageLiteral(resourceName: "legislator-detailpage_medal_gold")
        case "2":
            medalImgView.image = #imageLiteral(resourceName: "legislator-detailpage_medal_silver")
        case "3":
            medalImgView.image = #imageLiteral(resourceName: "legislator-detailpage_medal_bronze")
        default:
            medalImgView.deactivateAllConstraints()
            medalImgView.isHidden = true
        }
        switch data.unlikerank {
        case "1":
            bombImgView.image = #imageLiteral(resourceName: "legislator-detailpage_red_bomb")
        case "2":
            bombImgView.image = #imageLiteral(resourceName: "legislator-detailpage_orange_bomb")
        case "3":
            bombImgView.image = #imageLiteral(resourceName: "legislator-detailpage_yellow_bomb")
        default :
            bombImgView.isHidden = true
        }
        
        switch data.partyName {
        case .더불어민주당:
             legislatorProfileImgView.makeImgBorder(width: 3, color: ColorChip.shared().partyBlue)
        case .자유한국당:
            legislatorProfileImgView.makeImgBorder(width: 3, color: ColorChip.shared().partyRed)
        case .민중당:
            legislatorProfileImgView.makeImgBorder(width: 3, color: ColorChip.shared().partyOrange)
        case .바른미래당:
            legislatorProfileImgView.makeImgBorder(width: 3, color: ColorChip.shared().partyMint)
        case .정의당:
            legislatorProfileImgView.makeImgBorder(width: 3, color: ColorChip.shared().partyYellow)
        case .무소속:
            legislatorProfileImgView.makeImgBorder(width: 3, color: ColorChip.shared().partyGray)
        case .대한애국당:
            legislatorProfileImgView.makeImgBorder(width: 3, color: ColorChip.shared().partyNavy)
        case .민주평화당:
            legislatorProfileImgView.makeImgBorder(width: 3, color: ColorChip.shared().partyGreen)
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        legislatorProfileImgView.makeImageRound()
        
    }
}


