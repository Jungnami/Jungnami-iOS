//
//  TmiSecondCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 8..
//

import UIKit

class TmiSecondCell: UICollectionViewCell {
    
    @IBOutlet weak var tmiImgView: UIImageView!
    @IBOutlet weak var tmiTitleLbl: UILabel!
    @IBOutlet weak var tmiCategoryLbl: UILabel!
    @IBOutlet weak var tmiDateLbl: UILabel!
    
    func configure(data: ContentMenuSample) {
        tmiImgView.image = data.imgView
        tmiTitleLbl.text = data.title
        tmiCategoryLbl.text = data.category
        tmiDateLbl.text = data.date
    }
    
}
