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
    @IBOutlet weak var contentDetailImgCountLbl: UILabel!
    
    func configure(index : Int, data : ContentSample){
        contentDetailDateLbl.text = data.date
        contentDetailTitleLbl.text = data.title
        contentDetailCategoryLbl.text = data.category
        contentDetailImgCountLbl.text = data.imageCount
        //이미지를 어떻게 넣지?ㅎㅎㅎㅎㅎㅎㅎㅎ
        contentDetailImgView.image = data.images[index]
        contentDetailImgCountLbl.text = "\(index+1)/20"
    }
}
