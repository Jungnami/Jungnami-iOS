//
//  MainFirstSectionTVCell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 6..
//

import UIKit
import GTProgressBar
class MainFirstSectionTVCell: UITableViewCell {

    @IBOutlet weak var firstImgView: UIImageView!
    @IBOutlet weak var secondImgView: UIImageView!
    
    @IBOutlet weak var firstNameLbl: UILabel!
     @IBOutlet weak var secondNameLbl: UILabel!
     @IBOutlet weak var firstPartyLbl: UILabel!
     @IBOutlet weak var secondPartyLbl: UILabel!
    
   
    @IBOutlet weak var firstProgressBar: UIView!
    
    @IBOutlet weak var secondProgressBar: UIView!
    
    @IBOutlet weak var firstProgressBarLbl: UILabel!
     @IBOutlet weak var secondProgressBarLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
