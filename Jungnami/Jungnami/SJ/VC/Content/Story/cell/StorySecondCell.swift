//
//  StorySecondCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 8..
//

import UIKit

class StorySecondCell: UICollectionViewCell {
    
    @IBOutlet weak var storyImgView: UIImageView!
    @IBOutlet weak var storyTitleLbl: UILabel!
    @IBOutlet weak var storyCategoryLbl: UILabel!
    
    func configure(data: RecommendVODataContent) {
        
        storyCategoryLbl.text = data.text
        storyTitleLbl.text = data.title
        
        if (gsno(data.thumbnail) == "0") {
            storyImgView.image = UIImage()
        } else {
            
            if let url = URL(string: gsno(data.thumbnail)){
                self.storyImgView.kf.setImage(with: url)
                
            }
        }
    }
}
