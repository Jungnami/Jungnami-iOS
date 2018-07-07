//
//  CommunityFirstSectionTVCell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 7..
//

import UIKit

class CommunityFirstSectionWriteTVCell: UITableViewCell {
    
    @IBOutlet weak var userImgView: UIImageView!
    
    @IBOutlet weak var nextBtn: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
         userImgView.makeImageRound()
         nextBtn.contentHorizontalAlignment = .left
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
