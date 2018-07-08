//
//  SearchLegislatorResultTVCell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 3..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class SearchLegislatorResultTVCell: UITableViewCell {

    @IBOutlet weak var rankLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var rankDetailLbl: UILabel!
    @IBOutlet weak var regionLbl: UILabel!
    
    
    func configure(rank : Int, data : SampleLegislator){
        rankLbl.text = "\(rank)"
        profileImg.image = data.profile
        nameLbl.text = data.name
        rankDetailLbl.text = "호감 \(data.likeCount)위 / 비호감 \(data.dislikeCount)위"
        regionLbl.text = data.region
        switch data.party {
        case .blue:
            profileImg.makeImgBorder(width: 2, color: ColorChip.shared().partyBlue)
        case .red:
            profileImg.makeImgBorder(width: 2, color: ColorChip.shared().partyRed)
        case .yellow:
            profileImg.makeImgBorder(width: 2, color: ColorChip.shared().partyYellow)
        case .orange:
            profileImg.makeImgBorder(width: 2, color: ColorChip.shared().partyOrange)
        case .mint:
            profileImg.makeImgBorder(width: 2, color: ColorChip.shared().partyMint)
        }
        
        
        if rank % 2 == 0 {
            self.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImg.makeImageRound()
        //profileImg.layer.borderWidth = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
