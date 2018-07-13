//
//  SearchLegislatorResultTVCell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 3..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit
import Kingfisher

class SearchLegislatorResultTVCell: UITableViewCell {

    @IBOutlet weak var rankLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var rankDetailLbl: UILabel!
    @IBOutlet weak var regionLbl: UILabel!
    

    func configure(rank : Int, data : LegislatorSearchVOData){
        rankLbl.text = "\(rank)"
        if (gsno(data.imgurl) == "0") {
            profileImg.image = #imageLiteral(resourceName: "mypage_profile_girl")
        } else {
            if let url = URL(string: gsno(data.imgurl)){
                self.profileImg.kf.setImage(with: url)
            }
        }
        nameLbl.text = data.name
        rankDetailLbl.text = "\(data.rank)"
        regionLbl.text = data.position
        switch data.party {
        case .더불어민주당:
            profileImg.makeImgBorder(width: 2, color: ColorChip.shared().partyBlue)
        case .자유한국당:
            profileImg.makeImgBorder(width: 2, color: ColorChip.shared().partyRed)
        case .정의당:
            profileImg.makeImgBorder(width: 2, color: ColorChip.shared().partyYellow)
        case .민중당:
            profileImg.makeImgBorder(width: 2, color: ColorChip.shared().partyOrange)
        case .무소속:
            profileImg.makeImgBorder(width: 2, color: ColorChip.shared().partyGray)
        case .바른미래당:
            profileImg.makeImgBorder(width: 2, color: ColorChip.shared().partyMint)
        case .대한애국당:
            profileImg.makeImgBorder(width: 2, color: ColorChip.shared().partyNavy)
        case .민주평화당:
            profileImg.makeImgBorder(width: 2, color: ColorChip.shared().partyGreen)
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
