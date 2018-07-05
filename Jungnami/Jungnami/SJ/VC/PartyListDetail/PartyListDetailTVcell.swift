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
    
    func configure(index : Int, data : SampleLegislator2){
        indexLbl.text = "\(index+1)"
        profileImgView.image = data.profile
        nameLbl.text = data.name
        rankLbl.text = "\(data.rank)위"
        regionLbl.text = data.region
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
