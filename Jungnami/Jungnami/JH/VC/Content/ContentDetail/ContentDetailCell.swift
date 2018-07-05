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
    
//    func configure(data : CommentSample){
//        commentProfileImg.image = data.profile
//        commentUserLbl.text = data.userId
//        commentContentLbl.text = data.commentContent
//        commentDateLbl.text = data.date
//        commentLikeLbl.text = data.likeCount
//    }
}
