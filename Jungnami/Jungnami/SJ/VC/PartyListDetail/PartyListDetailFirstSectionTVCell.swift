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
    
    func configure2(selectedRegion : Region){
        switch selectedRegion {
        case .SEOUL:
            partyImgView.image = #imageLiteral(resourceName: "partylist_thin_bluebox")
        case .INCHEON:
            partyImgView.image = #imageLiteral(resourceName: "partylist_thin_bluebox")
        case .GYUNGGI:
            partyImgView.image = #imageLiteral(resourceName: "partylist_thin_bluebox")
        case .GANGWON:
            partyImgView.image = #imageLiteral(resourceName: "partylist_thin_bluebox")
        case .CHUNGNAM:
            partyImgView.image = #imageLiteral(resourceName: "partylist_thin_bluebox")
        case .CHUNGBUK:
            partyImgView.image = #imageLiteral(resourceName: "partylist_thin_bluebox")
        case .SEJONG:
            partyImgView.image = #imageLiteral(resourceName: "partylist_thin_bluebox")
        case .DAEJEON:
            partyImgView.image = #imageLiteral(resourceName: "partylist_thin_bluebox")
        case .GYUNGBUK:
            partyImgView.image = #imageLiteral(resourceName: "partylist_thin_bluebox")
        case .DAEGU:
            partyImgView.image = #imageLiteral(resourceName: "partylist_thin_bluebox")
        case .ULSAN:
            partyImgView.image = #imageLiteral(resourceName: "partylist_thin_bluebox")
        case .BUSAN:
            partyImgView.image = #imageLiteral(resourceName: "partylist_thin_bluebox")
        case .GYUNGNAM:
            partyImgView.image = #imageLiteral(resourceName: "partylist_thin_bluebox")
        case .JEONBUK:
            partyImgView.image = #imageLiteral(resourceName: "partylist_thin_bluebox")
        case .GWANGJU:
            partyImgView.image = #imageLiteral(resourceName: "partylist_thin_bluebox")
        case .JUNNAM:
            partyImgView.image = #imageLiteral(resourceName: "partylist_thin_bluebox")
        case .JEJU:
            partyImgView.image = #imageLiteral(resourceName: "partylist_thin_bluebox")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
