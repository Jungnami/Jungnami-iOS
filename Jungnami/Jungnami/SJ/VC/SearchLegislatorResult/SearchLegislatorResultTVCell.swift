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
    var red = UIColor(red: 225/255.0, green: 36/255.0, blue: 26/255.0, alpha: 1.0).cgColor
    
    var blue = UIColor(red: 23/255.0, green: 131/255.0, blue: 220/255.0, alpha: 1.0).cgColor
    
    func configure(rank : Int, data : SampleLegislator){
        rankLbl.text = "\(rank)"
        profileImg.image = data.profile
        nameLbl.text = data.name
        rankDetailLbl.text = "호감 \(data.likeCount)위 / 비호감 \(data.dislikeCount)위"
        regionLbl.text = data.region
        if (data.party == "민주당"){
            profileImg.layer.borderColor = blue
        } else {
            profileImg.layer.borderColor = red
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImg.makeImageRound()
        profileImg.layer.borderWidth = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
