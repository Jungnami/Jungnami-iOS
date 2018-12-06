//
//  NoticeFollowCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 7..
//

import UIKit
import Kingfisher

class NoticeCell: UITableViewCell {
    //----tapGesture--------------
    var delegate : TapDelegate?
    var index = 0
    //------------------------------
    @IBOutlet weak var noticeProfileImgView: UIImageView!
    
    @IBOutlet weak var noticeUserLbl: UILabel!
    @IBOutlet weak var noticeTypeLbl: UILabel!
    @IBOutlet weak var noticeDateLbl: UILabel!
    
    @IBOutlet weak var followBtn: followBtn!
    
    //type에 따라서 이미지 바뀌어야 함
    
    var check: Bool = true // ?
   
    func configure(data: AlarmVOData, index : Int) {
       
        if (gsno(data.imgURL) == "0") {
            noticeProfileImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
        } else {
            if let url = URL(string: gsno(data.imgURL)){
                self.noticeProfileImgView.kf.setImage(with: url)
            }
        }
        noticeUserLbl.text = data.actionname
        noticeTypeLbl.text = data.actionmessage
        noticeDateLbl.text = data.time
        
        let followType = data.button
      
        
        followBtn.setImage(UIImage(named: "mypage_follow"), for: .normal)
        followBtn.setImage(UIImage(named: "mypage_following"), for: .selected)
        //팔로우가 들어온다는 것은 아직 팔로잉 한 상태가 아니라는 것 => 그러니까 .isSelected = false
        //팔로잉이 들어온다는 것은 팔로잉을 하고 있다는것 => 그러니까 .isSelected = true
        followBtn.isFollow = data.button
        followBtn.userIdx = data.id
        followBtn.indexPath = index
        
        if followType == "팔로우" {
            followBtn.isSelected = false
            followBtn.isHidden = false
            
        } else if followType == "팔로잉" {
            followBtn.isSelected = true
            followBtn.isHidden = false
        } else {
            followBtn.isHidden = true
        }
       
        //나중에 id 넘겨서 딜리게이트로 넘겨야함
        if data.ischecked == 0 {
            //체크 안한거
            self.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9882352941, blue: 1, alpha: 1)
        } else {
            //체크 한거
            self.backgroundColor = .white
        }
        
    }

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        noticeProfileImgView.makeImageRound()
        //tapGesture-----------------------------------------
        noticeProfileImgView.isUserInteractionEnabled = true
        noticeUserLbl.isUserInteractionEnabled = true
        
        
        let imgTapGesture = UITapGestureRecognizer(target: self, action: #selector(NoticeCell.imgTap(sender:)))
        let lblTapGesture = UITapGestureRecognizer(target: self, action: #selector(NoticeCell.lblTap(sender:)))
        self.noticeUserLbl.addGestureRecognizer(lblTapGesture)
        self.noticeProfileImgView.addGestureRecognizer(imgTapGesture)
    }
    @objc func imgTap(sender: UITapGestureRecognizer) {
        delegate?.myTableDelegate(index : index)
    }
    @objc func lblTap(sender: UITapGestureRecognizer) {
        delegate?.myTableDelegate(index : index)
    }
    //-----------------------------------------------------
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
