//
//  PartyListDetailTVcell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 5..
//

import UIKit
import Kingfisher

class PartyListDetailTVcell: UITableViewCell {
    
    @IBOutlet weak var indexLbl: UILabel!
    
    @IBOutlet weak var profileImgView: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var rankLbl: UILabel!
    
    @IBOutlet weak var regionLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    func configure(index : Int, data : PartyLegistorLikeVOData){
        indexLbl.text = "\(data.rank)"
        if (gsno(data.imgurl) == "0") {
            profileImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
        } else {
            if let url = URL(string: gsno(data.imgurl)){
                self.profileImgView.kf.setImage(with: url)
            }
        }
      
        nameLbl.text = data.name
        rankLbl.text = data.rankInAll
        regionLbl.text = data.position
        switch data.partyName {
        case .더불어민주당:
            profileImgView.layer.borderColor = ColorChip.shared().partyBlue.cgColor
        case .자유한국당:
            profileImgView.layer.borderColor = ColorChip.shared().partyRed.cgColor
        case .바른미래당:
            profileImgView.layer.borderColor = ColorChip.shared().partyMint.cgColor
        case .정의당:
            profileImgView.layer.borderColor = ColorChip.shared().partyYellow.cgColor
        case .민중당:
            profileImgView.layer.borderColor = ColorChip.shared().partyOrange.cgColor
        case .무소속:
            profileImgView.layer.borderColor =
            ColorChip.shared().partyGray.cgColor
        case .대한애국당:
            profileImgView.layer.borderColor =
            ColorChip.shared().partyNavy.cgColor
        case .민주평화당:
            profileImgView.layer.borderColor =
            ColorChip.shared().partyGreen.cgColor
        }
        
        if index % 2 == 1 {
            self.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        }
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImgView.makeImageRound()
        profileImgView.layer.borderWidth = 2
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
