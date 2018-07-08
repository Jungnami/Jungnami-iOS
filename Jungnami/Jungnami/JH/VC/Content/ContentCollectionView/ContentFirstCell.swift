//
//  ContentFirstCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 2..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class ContentFirstCell: UICollectionViewCell {
    
    @IBOutlet weak var recommendImgView: UIImageView!
    @IBOutlet weak var recommendTitleLbl: UILabel!
    @IBOutlet weak var recommendCategoryLbl: UILabel!
    
    
    @IBOutlet weak var recommendContentDate: UILabel!
    
    
    func configure(data: ContentMenuSample) {
        recommendImgView.image = data.imgView
        recommendTitleLbl.text = data.title
        recommendCategoryLbl.text = data.category
        recommendContentDate.text = data.date
        
    }
    
    
}
