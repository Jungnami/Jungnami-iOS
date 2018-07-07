//
//  LegislatorContentCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 7..
//

import UIKit

class LegislatorContentCell: UICollectionViewCell {
    
    @IBOutlet weak var legislatorContentImgView: UIImageView!
    @IBOutlet weak var legislatorTitleLbl: UILabel!
    @IBOutlet weak var legislatorContentCategoryLbl: UILabel!
    
    @IBOutlet weak var legislatorContentDate: UILabel!
    
    var contents = ContentMenuData.sharedInstance.contentMenus
    func configure(index: Int, data: ContentSample) {
        legislatorContentImgView.image = data.images[index]
        legislatorTitleLbl.text = data.title
        legislatorContentDate.text = data.date
        legislatorContentCategoryLbl.text = data.category
    }
}
