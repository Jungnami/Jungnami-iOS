//
//  ContentSearchResultCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 13..
//

import UIKit
import Kingfisher

class ContentSearchResultCell: UICollectionViewCell {
    
    @IBOutlet weak var contentImgView: UIImageView!
    @IBOutlet weak var contentTitleLbl: UILabel!
    @IBOutlet weak var contentInfoLbl: UILabel!

    func configure(data: ContentSearchVOData) {
        if (gsno(data.thumbnail) == "0") {
            contentImgView.image = UIImage()
        } else {
            if let url = URL(string: gsno(data.thumbnail)){
                self.contentImgView.kf.setImage(with: url)
            }
        }
        contentTitleLbl.text = data.title
        contentInfoLbl.text = data.text
    }
    
}
