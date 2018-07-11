//
//  ScrapCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 4..
//

import UIKit

class ScrapCell: UICollectionViewCell {
    
    @IBOutlet weak var scrapImgView: UIImageView!
    
    @IBOutlet weak var scrapTitleLbl: UILabel!
    @IBOutlet weak var scrapCategoryLbl: UILabel!

    func configure(data : MyPageVODataScrap){
        scrapCategoryLbl.text = data.text
        scrapTitleLbl.text = data.cTitle
      
       
        
        if (gsno(data.thumbnail) == "0") {
            scrapImgView.image = #imageLiteral(resourceName: "dabi")
        } else {
            if let url = URL(string: gsno(data.thumbnail)){
                self.scrapImgView.kf.setImage(with: url)
            }
        }

    }
    
}
