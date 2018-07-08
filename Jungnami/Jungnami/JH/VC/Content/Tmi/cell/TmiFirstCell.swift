//
//  TmiFirstCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 8..
//

import UIKit

class TmiFirstCell: UICollectionViewCell {
    
    @IBOutlet weak var tmiImgView: UIImageView!
    @IBOutlet weak var tmiDateLbl: UILabel!
    @IBOutlet weak var tmiTitleLbl: UILabel!
    @IBOutlet weak var tmiCategoryLbl: UILabel!
    
    func configure(data: ContentMenuSample) {
        tmiImgView.image = data.imgView
        tmiTitleLbl.text = data.title
        tmiCategoryLbl.text = data.category
        tmiDateLbl.text = data.date
    }
}
