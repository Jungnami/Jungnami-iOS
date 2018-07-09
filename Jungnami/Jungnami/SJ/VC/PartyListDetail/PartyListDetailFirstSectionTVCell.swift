//
//  PartyListDetailFirstSectionTVCell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 5..
//

import UIKit

class PartyListDetailFirstSectionTVCell: UITableViewCell {
    
    @IBOutlet weak var partyImgView: UIImageView!
    func configure(selectedParty : PartyName){
        switch selectedParty {
        case .더불어민주당:
            partyImgView.image = #imageLiteral(resourceName: "partylist_bluebox")
        case .자유한국당:
            partyImgView.image = #imageLiteral(resourceName: "partylist_redbox")
        case .바른미래당 :
            partyImgView.image = #imageLiteral(resourceName: "partylist_mintbox")
        case .정의당:
             partyImgView.image = #imageLiteral(resourceName: "partylist_yellowbox")
        case .민중당 :
            partyImgView.image = #imageLiteral(resourceName: "partylist_orangebox")
        case .무소속:
            partyImgView.image = #imageLiteral(resourceName: "partylist_orangebox")
        case .대한애국당:
            partyImgView.image = #imageLiteral(resourceName: "partylist_orangebox")
        case .민주평화당:
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
