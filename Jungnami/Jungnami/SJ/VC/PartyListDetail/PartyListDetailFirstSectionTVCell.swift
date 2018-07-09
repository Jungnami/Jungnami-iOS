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
            partyImgView.image = #imageLiteral(resourceName: "area_seoul_bluebox")
        case .INCHEON:
            partyImgView.image = #imageLiteral(resourceName: "area_incheon_skybluebox")
        case .GYUNGGI:
            partyImgView.image = #imageLiteral(resourceName: "area_gyeonggi_skybluebox")
        case .GANGWON:
            partyImgView.image = #imageLiteral(resourceName: "area_gangwon_redbox")
        case .CHUNGNAM:
            partyImgView.image = #imageLiteral(resourceName: "area_chungnam_pinkbox")
        case .CHUNGBUK:
            partyImgView.image = #imageLiteral(resourceName: "area_chungbuk_pinkbox")
        case .SEJONG:
            partyImgView.image = #imageLiteral(resourceName: "area_sejong_pinkbox")
        case .DAEJEON:
            partyImgView.image = #imageLiteral(resourceName: "area_daejeon_pinkbox")
        case .GYUNGBUK:
            partyImgView.image = #imageLiteral(resourceName: "area_gyeongbuk_redbox")
        case .DAEGU:
            partyImgView.image = #imageLiteral(resourceName: "area_daegu_pinkbox")
        case .ULSAN:
            partyImgView.image = #imageLiteral(resourceName: "area_ulsan_pinkbox")
        case .BUSAN:
            partyImgView.image = #imageLiteral(resourceName: "area_busan_redbox")
        case .GYUNGNAM:
            partyImgView.image = #imageLiteral(resourceName: "area_gyeongnam_redbox")
        case .JEONBUK:
            partyImgView.image = #imageLiteral(resourceName: "area_jeonbuk_mintbox")
        case .GWANGJU:
            partyImgView.image = #imageLiteral(resourceName: "area_gwangju_greenbox")
        case .JUNNAM:
            partyImgView.image = #imageLiteral(resourceName: "area_jeonnam_greenbox")
        case .JEJU:
            partyImgView.image = #imageLiteral(resourceName: "area_jeju_bluebox")
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
