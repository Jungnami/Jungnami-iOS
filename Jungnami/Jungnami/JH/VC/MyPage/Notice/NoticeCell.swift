//
//  NoticeFollowCell.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 7..
//

import UIKit

class NoticeCell: UITableViewCell {
    
    @IBOutlet weak var noticeProfileImgView: UIImageView!
    
    @IBOutlet weak var noticeUserLbl: UILabel!
    @IBOutlet weak var noticeTypeLbl: UILabel!
    @IBOutlet weak var noticeDateLbl: UILabel!
    
    @IBOutlet weak var followBtn: UIButton!
    
    @IBOutlet weak var noticeTypeImgView: UIImageView!
    //type에 따라서 이미지 바뀌어야 함
    
    var check: Bool = true // ?
    @IBAction func noticeFollowBtn(_ sender: Any) {
        if check { //check상태이면
            followBtn.setImage(#imageLiteral(resourceName: "mypage_follow"), for: .selected)
        }else {
            followBtn.setImage(#imageLiteral(resourceName: "mypage_following"), for: .selected)
        }
        
        //투두 - 버튼 다시 눌렀을 때 팔로우로 바뀌어야 함
        
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        noticeProfileImgView.layer.cornerRadius = noticeProfileImgView.layer.frame.size.width / 2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}