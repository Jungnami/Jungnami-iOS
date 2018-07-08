//
//  StoryFirstCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 8..
//

import UIKit

class StoryFirstCell: UICollectionViewCell {
    
    @IBOutlet weak var storyImgView: UIImageView!
    @IBOutlet weak var storyDateLbl: UILabel!
    @IBOutlet weak var storyTitleLbl: UILabel!
    @IBOutlet weak var storyCategoryLbl: UILabel!
    
    func configure(data: ContentMenuSample) {
        storyImgView.image = data.imgView
        storyDateLbl.text = data.date
        storyTitleLbl.text = data.title
        storyCategoryLbl.text = data.category
    }
}
