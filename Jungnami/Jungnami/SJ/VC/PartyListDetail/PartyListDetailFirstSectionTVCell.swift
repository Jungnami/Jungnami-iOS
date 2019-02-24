//
//  PartyListDetailFirstSectionTVCell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 5..
//

import UIKit

class PartyListDetailFirstSectionTVCell: UITableViewCell {
    
    @IBOutlet weak var partyImgView: UIImageView!
    func configure(selectedParty : PartyCode){
        partyImgView.image = selectedParty.partyThinImg
    }
    
    func configure2(selectedRegion : CityCode){
         partyImgView.image = selectedRegion.cityThinImg
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
