//
//  PartyListDetailFirstSectionTVCell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 5..
//

import UIKit

class PartyListDetailFirstSectionTVCell: UITableViewCell {
    
    @IBOutlet weak var partyImgView: UIImageView!
    func configure(selectedParty : PartyList){
        switch selectedParty {
        case .blue:
            partyImgView.image = #imageLiteral(resourceName: "partylist_bluebox")
        case .red:
            partyImgView.image = #imageLiteral(resourceName: "partylist_redbox")
        case .green :
            partyImgView.image = #imageLiteral(resourceName: "partylist_mintbox")
        case .yellow :
             partyImgView.image = #imageLiteral(resourceName: "partylist_yellowbox")
        case .orange :
            partyImgView.image = #imageLiteral(resourceName: "partylist_orangebox")
        }
       
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
