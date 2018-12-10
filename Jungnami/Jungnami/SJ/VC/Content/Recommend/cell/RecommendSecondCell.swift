//
//  ContentSecondCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 2..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class RecommendSecondCell: UICollectionViewCell {
    
    @IBOutlet weak var contentImgView: UIImageView!
    @IBOutlet weak var contentTitleLbl: UILabel!
    @IBOutlet weak var contentTypeLbl: UILabel!
    @IBOutlet weak var contentDate: UILabel!
    func configure(data: RecommendVODataContent) {
        
        contentTitleLbl.text = data.title
        contentTypeLbl.text = data.text
        
        if (gsno(data.thumbnail) == "0") {
            contentImgView.image = UIImage()
        } else {
            
            if let url = URL(string: gsno(data.thumbnail)){
                self.contentImgView.kf.setImage(with: url)
                
            }
        }
    }

}
