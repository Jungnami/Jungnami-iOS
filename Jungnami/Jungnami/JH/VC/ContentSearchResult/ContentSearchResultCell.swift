//
//  ContentSearchResultCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 13..
//

import UIKit

class ContentSearchResultCell: UICollectionViewCell {
    
    @IBOutlet weak var contentImgView: UIImageView!
    @IBOutlet weak var contentTitleLbl: UILabel!
    @IBOutlet weak var contentInfoLbl: UILabel!
    //수진님 통신 - ContentSearchResultData 여기 통신데이터로 바꿔주세욤
    func configure(data: ContentsearchResultSample) {
        contentImgView.image = data.img
        contentTitleLbl.text = data.title
        contentInfoLbl.text = data.info
    }
    
}
