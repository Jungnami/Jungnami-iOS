//
//  CommunityFirstSectionTVCell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 7..
//

import UIKit
import Kingfisher

class CommunityFirstSectionWriteTVCell: UITableViewCell {
    
    @IBOutlet weak var userImgView: UIImageView!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    func configure(_ imgURL : String){
        if (gsno(imgURL) == "0") {
            userImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
           
        } else {
            if let url = URL(string: gsno(imgURL)){
                self.userImgView.kf.setImage(with: url)
            }
        }
    }

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
