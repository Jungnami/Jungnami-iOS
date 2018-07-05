//
//  ScrapCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 4..
//

import UIKit

class ScrapCell: UICollectionViewCell {
    
    @IBOutlet weak var scarpImgView: UIImageView!
    
    @IBOutlet weak var scrapTitleLbl: UILabel!
    @IBOutlet weak var scrapCategoryLbl: UILabel!
    @IBOutlet weak var scrapDateLbl: UILabel!
    
    func configure(data : ScrapSample){
        scrapDateLbl.text = data.scrapDate
        scrapTitleLbl.text = data.scrapTitle
        scrapCategoryLbl.text = data.scrapCategory
        scarpImgView.image = data.scrapImgView
        scrapDateLbl.text = data.scrapDate
        
//        commentContentLbl.text = data.commentContent
//        commentDateLbl.text = data.date
//        commentLikeLbl.text = data.likeCount
    }
}
