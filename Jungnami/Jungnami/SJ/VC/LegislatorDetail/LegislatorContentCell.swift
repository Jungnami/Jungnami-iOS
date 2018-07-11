//
//  LegislatorContentCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 7..
//

import UIKit
import Kingfisher

class LegislatorContentCell: UICollectionViewCell {
    
    @IBOutlet weak var legislatorContentImgView: UIImageView!
    @IBOutlet weak var legislatorTitleLbl: UILabel!
    @IBOutlet weak var legislatorContentCategoryLbl: UILabel!
    
    @IBOutlet weak var legislatorContentDate: UILabel!
    
    var legisContents = LegislatorContentData.sharedInstance.legislatorContents
    func configure(data: LegislatorDetailVODataContent) {
        if (gsno(data.thumbnailURL) == "0") {
            legislatorContentImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
        } else {
            if let url = URL(string: gsno(data.thumbnailURL)){
                
                self.legislatorContentImgView.kf.setImage(with: url)
            }
        }
        legislatorTitleLbl.text = data.title
        legislatorContentDate.text = data.writingtime
        legislatorContentCategoryLbl.text = data.category
    }
}
