//
//  FollowListCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 8..
//

import UIKit
import Kingfisher

class followBtn : UIButton {
    var isFollow : String? //
    var userIdx : String?
    var indexPath : Int = 0
}

class FollowCell: UITableViewCell {

    var delegate : TapDelegate?
    var index = 0
    
    @IBOutlet weak var followImgView: UIImageView!
    
    @IBOutlet weak var followNickNameLbl: UILabel!
    //팔로우버튼
    //스토리보드 갔다와서 여기서부터 다시
    @IBOutlet weak var followCancelBtn: followBtn!
    
  
    func configure(data : FollowListVOData, index : Int){
        if (gsno(data.followingImgURL) == "") {
            followImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
            
        } else {
            if let url = URL(string: gsno(data.followingImgURL)){
                self.followImgView.kf.setImage(with: url)
            }
        }
        
        followNickNameLbl.text = data.followingNickname

        followCancelBtn.setImage(UIImage(named: "mypage_follow"), for: .normal)
        followCancelBtn.setImage(UIImage(named: "mypage_following"), for: .selected)
       //팔로우가 들어온다는 것은 아직 팔로잉 한 상태가 아니라는 것 => 그러니까 .isSelected = false
        //팔로잉이 들어온다는 것은 팔로잉을 하고 있다는것 => 그러니까 .isSelected = true
        followCancelBtn.isFollow = data.isMyFollowing
        followCancelBtn.userIdx = data.followingID
        followCancelBtn.indexPath = index
        if data.isMyFollowing == "팔로우" {
            followCancelBtn.isSelected = false
        } else if data.isMyFollowing == "팔로잉"{
            followCancelBtn.isSelected = true
        } else {
            followCancelBtn.isHidden = true
        }
    }
    
    func configure2(data : FollowerListVOData, index : Int){
        if (gsno(data.followerImgURL) == "") {
            followImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
            
        } else {
            if let url = URL(string: gsno(data.followerImgURL)){
                self.followImgView.kf.setImage(with: url)
            }
        }
        
        followNickNameLbl.text = data.followerNickname
        
        followCancelBtn.setImage(UIImage(named: "mypage_follow"), for: .normal)
        followCancelBtn.setImage(UIImage(named: "mypage_following"), for: .selected)
        //팔로우가 들어온다는 것은 아직 팔로잉 한 상태가 아니라는 것 => 그러니까 .isSelected = false
        //팔로잉이 들어온다는 것은 팔로잉을 하고 있다는것 => 그러니까 .isSelected = true
        followCancelBtn.isFollow = data.isMyFollowing
        followCancelBtn.userIdx = data.followerID
        followCancelBtn.indexPath = index
        if data.isMyFollowing == "팔로우" {
            followCancelBtn.isSelected = false
        } else if data.isMyFollowing == "팔로잉"{
            followCancelBtn.isSelected = true
        } else {
            followCancelBtn.isHidden = true
        }
    }
   
        override func awakeFromNib() {
        super.awakeFromNib()
        //이미지 깎기
        followImgView.makeImageRound()
        //탭레코그나이저
        followImgView.isUserInteractionEnabled = true
        followNickNameLbl.isUserInteractionEnabled = true
    }

    //선택됐을 때
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    
    }

}
