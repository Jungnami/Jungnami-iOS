//
//  PartyListDetailTVcell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 5..
//

import UIKit

class PartyListDetailTVcell: UITableViewCell {
    
    @IBOutlet weak var indexLbl: UILabel!
    
    @IBOutlet weak var profileImgView: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var rankLbl: UILabel!
    
    @IBOutlet weak var regionLbl: UILabel!
    
    func configure(index : Int, data : SampleLegislator){
        indexLbl.text = "\(index+1)"
        profileImgView.image = data.profile
        nameLbl.text = data.name
        rankLbl.text = "\(data.likeRank)위"
        regionLbl.text = data.region
        switch data.party {
        case .blue:

            profileImgView.layer.borderColor = ColorChip.shared().partyBlue.cgColor
        case .red:
            profileImgView.layer.borderColor = ColorChip.shared().partyRed.cgColor
        case .mint:
            profileImgView.layer.borderColor = ColorChip.shared().partyMint.cgColor
        case .yellow:
            profileImgView.layer.borderColor = ColorChip.shared().partyYellow.cgColor
        case .orange:
            profileImgView.layer.borderColor = ColorChip.shared().partyOrange.cgColor

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
