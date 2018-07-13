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
    
    func configure(data: RecommendVODataContent) {
        
        tmiTitleLbl.text = data.title
        tmiCategoryLbl.text = data.text
        if (gsno(data.thumbnail) == "0") {
            tmiImgView.image = #imageLiteral(resourceName: "yunhwan")
        } else {
            
            if let url = URL(string: gsno(data.thumbnail)){
                self.tmiImgView.kf.setImage(with: url)
                
            }
        }
    }
}
