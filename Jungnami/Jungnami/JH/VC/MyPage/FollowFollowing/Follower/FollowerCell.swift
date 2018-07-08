//
//  FollowerCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 8..
//

import UIKit

class FollowerCell: UITableViewCell {

    @IBOutlet weak var followerProfileImgView: UIImageView!
    @IBOutlet weak var followerNameLbl: UILabel!
    @IBOutlet weak var followerNicknameLbl: UILabel!
    //나를 팔로우하는 사람 중 내가 팔로우하지않은 사람의 경우 팔로우 버튼
    @IBAction func followBtn(_ sender: Any) {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        followerProfileImgView.makeImageRound()
        
    }
    
    func configure(data: FollowListSample) {
        followerProfileImgView.image = data.profileImg
        followerNameLbl.text = data.user
        followerNicknameLbl.text = data.nickName
        //팔로우 true 일 때는 빈팔로우버튼
        //팔로우 false 일 때는 팔로우버튼
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
