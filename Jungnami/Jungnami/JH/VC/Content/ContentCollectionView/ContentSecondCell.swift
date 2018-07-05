//
//  ContentSecondCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 2..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class ContentSecondCell: UICollectionViewCell {
    
    @IBOutlet weak var contentImgView: UIImageView!
    @IBOutlet weak var contentTitleLbl: UILabel!
    @IBOutlet weak var contentTypeLbl: UILabel!
    @IBOutlet weak var contentTypeImgView: UIImageView!
    
    @IBOutlet weak var contentDate: UILabel!
    
    func configure(data: ContentMenuSample) {
        contentImgView.image = data.imgView
        contentTypeImgView.image = data.typeImg
        contentTitleLbl.text = data.title
        contentDate.text = data.date
        contentTypeLbl.text = data.category
    }
}
