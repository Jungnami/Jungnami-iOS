//
//  MyPageScrapCVCell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 8. 7..
//

import UIKit
import Kingfisher

class MyPageScrapCVCell: UICollectionViewCell {

    @IBOutlet weak var scrapImgView: UIImageView!
    
    @IBOutlet weak var scrapTitleLbl: UILabel!
    @IBOutlet weak var scrapCategoryLbl: UILabel!
    
    func configure(data : MyPageVODataScrap){
        scrapCategoryLbl.text = data.text
        scrapTitleLbl.text = data.cTitle
        if (gsno(data.thumbnail) == "0") {
            scrapImgView.image = UIImage()
        } else {
            if let url = URL(string: gsno(data.thumbnail)){
                self.scrapImgView.kf.setImage(with: url)
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
