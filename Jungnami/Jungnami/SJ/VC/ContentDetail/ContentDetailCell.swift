//
//  ContentDetailCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 5..
//

import UIKit

class ContentDetailCell: UICollectionViewCell {
    //이미지
    @IBOutlet weak var contentDetailImgView: UIImageView!
    
    @IBOutlet weak var contentDetailTitleLbl: UILabel!
    @IBOutlet weak var contentDetailCategoryLbl: UILabel!
    @IBOutlet weak var contentDetailDateLbl: UILabel!
    
    func configure(title : String, text : String, thumnail : String){
        contentDetailTitleLbl.isHidden = false
        contentDetailDateLbl.isHidden = true
        contentDetailCategoryLbl.text = text
        //contentDetailDateLbl.text = writeTime
        if let url = URL(string: gsno(thumnail)){
            self.contentDetailImgView.kf.setImage(with: url)
            
        }
    }
    func configure2(data: ContentDetailVODataImgArr){
        if let url = URL(string: gsno(data.imgURL)){
            self.contentDetailImgView.kf.setImage(with: url)
            contentDetailTitleLbl.isHidden = true
            contentDetailDateLbl.isHidden = true
            contentDetailCategoryLbl.isHidden = true
        }
    }
}
