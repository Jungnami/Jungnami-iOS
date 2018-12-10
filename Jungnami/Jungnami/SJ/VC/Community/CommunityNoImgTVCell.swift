//
//  CommunityNoImgTVCell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 8. 6..


import UIKit
import Kingfisher
import SnapKit


class CommunityNoImgTVCell: UITableViewCell {
    
    @IBOutlet weak var profileImgView: myTouchImg!
    @IBOutlet weak var nameLabel: myTouchLbl!
    //스토리보드에서 imgView, Lbl에서 class myTouchImg, myTouchLbl로 바꾸기!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var heartBtn : myHeartBtn!
    @IBOutlet weak var commentBtn : myCommentBtn!
    @IBOutlet weak var warningBtn: ReportButton!
    @IBOutlet weak var scrapBtn : UIButton!
  
    //tapGesture-------------------------------
    var index = 0
    var delegate: TapDelegate2?
   
    //-----------------------------------------
    
   
    
    func configure(index : Int, data : CommunityVODataContent){
        self.index = index
        
        commentBtn.commentCnt = data.commentcnt
        commentBtn.likeCnt = data.likecnt
        heartBtn.setImage(UIImage(named: "community_heart"), for: .normal)
        heartBtn.setImage(UIImage(named: "community_heart_blue"), for: .selected)
         heartBtn.indexPath = index
        heartBtn.likeCnt = data.likecnt
        nameLabel.text = data.nickname
        timeLabel.text = data.writingtime
        contentLabel.text = data.content
        contentLabel.sizeToFit()
        warningBtn.selectedIdx = data.boardid
        likeLabel.text = "\(data.likecnt)"
        commentLabel.text = "\(data.commentcnt)"
        if data.islike == 0 {
            heartBtn.isSelected = false
        } else {
            heartBtn.isSelected = true
        }
        //킹피셔
        if (gsno(data.userimg) == "") {
            profileImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
        } else {
            if let url = URL(string: gsno(data.userimg)){
                
                self.profileImgView.kf.setImage(with: url)
            }
        }
        
        
        //여기 고치기
        
        profileImgView.userId = data.userId
        nameLabel.userId = data.userId
        
        // profileImgView.userId = data.
        //nameLabel.userId = data.userimg!
    }
    
    func configure2(index : Int, data : CommunitySearchVOData){
        self.index = index
        
        commentBtn.commentCnt = data.commentcnt
        commentBtn.likeCnt = data.likecnt
        heartBtn.setImage(UIImage(named: "community_heart"), for: .normal)
        heartBtn.setImage(UIImage(named: "community_heart_blue"), for: .selected)
         heartBtn.indexPath = index
        heartBtn.likeCnt = data.likecnt
        nameLabel.text = data.nickname
        timeLabel.text = data.writingtime
        contentLabel.text = data.content
        contentLabel.sizeToFit()
        warningBtn.selectedIdx = data.id
        likeLabel.text = "\(data.likecnt)"
        commentLabel.text = "\(data.commentcnt)"
        if data.islike == 0 {
            heartBtn.isSelected = false
        } else {
            heartBtn.isSelected = true
        }
        //킹피셔
        if (gsno(data.userImgURL) == "") {
            profileImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
        } else {
            if let url = URL(string: gsno(data.userImgURL)){
                
                self.profileImgView.kf.setImage(with: url)
            }
        }
        
        
        //여기 고치기
        
        profileImgView.userId = data.userId
        nameLabel.userId = data.userId
        
        // profileImgView.userId = data.
        //nameLabel.userId = data.userimg!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImgView.makeImageRound()
        //탭제스처 레코그나이저
        profileImgView.isUserInteractionEnabled = true
        nameLabel.isUserInteractionEnabled = true
        
        let imgTapGesture = UITapGestureRecognizer(target: self, action: #selector(CommunityTVCell.imgTap(sender:)))
        
        let lblTapGesture = UITapGestureRecognizer(target: self, action: #selector(CommunityTVCell.lblTap(sender:)))
        
        self.nameLabel.addGestureRecognizer(lblTapGesture)
        self.profileImgView.addGestureRecognizer(imgTapGesture)
      
    }
  
    //tapGesture
    @objc func imgTap(sender: UITapGestureRecognizer) {
        delegate?.myTableDelegate(sender : sender)
        
    }
    @objc func lblTap(sender: UITapGestureRecognizer) {
        delegate?.myTableDelegate(sender : sender)
    }
    
    
    
}


