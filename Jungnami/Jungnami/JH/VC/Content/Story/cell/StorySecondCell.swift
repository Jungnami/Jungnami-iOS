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
    @IBOutlet weak var storyDateLbl: UILabel!
    
    func configure(data: ContentMenuSample) {
        storyImgView.image = data.imgView
        storyDateLbl.text = data.date
        storyCategoryLbl.text = data.category
        storyTitleLbl.text = data.title
    }
}
