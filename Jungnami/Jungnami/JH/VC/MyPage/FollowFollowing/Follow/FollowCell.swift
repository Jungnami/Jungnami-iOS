//
//  FollowListCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 8..
//

import UIKit

class FollowCell: UITableViewCell {

    @IBOutlet weak var followImgView: UIImageView!
    @IBOutlet weak var followUserLbl: UILabel!
    @IBOutlet weak var followNickNameLbl: UILabel!
    //팔로우버튼
    @IBAction func followBtn(_ sender: Any) {
        
    }
    
    func configure(data: FollowListSample) {
        followImgView.image = data.profileImg
        followUserLbl.text = data.user
        followNickNameLbl.text = data.nickName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //이미지 깎기
        followImgView.makeImageRound()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
