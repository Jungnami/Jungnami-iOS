//
//  FollowListCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 8..
//

import UIKit

class FollowCell: UITableViewCell {

    var delegate : TapDelegate?
    var index = 0
    
    @IBOutlet weak var followImgView: UIImageView!
    
    @IBOutlet weak var followNickNameLbl: UILabel!
    //팔로우버튼
    
    @IBOutlet weak var followCancelBtn: UIButton!
    @IBAction func followBtn(_ sender: Any) {
        followCancelBtn.setImage(#imageLiteral(resourceName: "mypage_follow"), for: .normal)
    }
    
    func configure(data: FollowListSample) {
        followImgView.image = data.profileImg
        followNickNameLbl.text = data.nickName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //이미지 깎기
        followImgView.makeImageRound()
        //탭레코그나이저
        followImgView.isUserInteractionEnabled = true
        followNickNameLbl.isUserInteractionEnabled = true
        
        let imgTapGesture = UITapGestureRecognizer(target: self, action: #selector(RecommentCell.imgTap(sender:)))
        let lblTapGesture = UITapGestureRecognizer(target: self, action: #selector(RecommentCell.lblTap(sender:)))
        self.followNickNameLbl.addGestureRecognizer(lblTapGesture)
        self.followImgView.addGestureRecognizer(imgTapGesture)
        
    }
    @objc func imgTap(sender: UITapGestureRecognizer) {
        delegate?.myTableDelegate(index : index)
    }
    @objc func lblTap(sender: UITapGestureRecognizer) {
        delegate?.myTableDelegate(index : index)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
