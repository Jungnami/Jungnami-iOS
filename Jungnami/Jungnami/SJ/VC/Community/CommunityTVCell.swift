//
//  CommunityTVCell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 2..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit


class myHeartBtn : UIButton {
    var isLike : Int?
    var boardIdx : Int?
    var indexPath : Int = 0
    var likeCnt : Int = 0
}

class myCommentBtn : UIButton {
    var likeCnt : Int = 0
    var commentCnt : Int = 0
}


class CommunityTVCell: UITableViewCell {
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var contentImgView : UIImageView!
    @IBOutlet weak var heartBtn : myHeartBtn!
    @IBOutlet weak var commentBtn : myCommentBtn!
    @IBOutlet weak var scrapBtn : UIButton!
    
    var delegate: TapDelegate?
    var doubleTapdelegate: DoubleTapDelegate?

    
    
    var index : Int = 0
    func configure(index : Int, data : CommunityVODataContent){
        self.index = index

        commentBtn.commentCnt = data.commentcnt
        commentBtn.likeCnt = data.likecnt
        heartBtn.setImage(UIImage(named: "community_heart"), for: .normal)
        heartBtn.setImage(UIImage(named: "community_heart_blue"), for: .selected)
         //default A image display
        
        heartBtn.likeCnt = data.likecnt
        nameLabel.text = data.nickname
        timeLabel.text = data.writingtime
        contentLabel.text = data.content
        contentLabel.sizeToFit()
        likeLabel.text = "\(data.likecnt)"
        commentLabel.text = "\(data.commentcnt)"
        if data.islike == 0 {
            heartBtn.isSelected = false
        } else {
            heartBtn.isSelected = true
        }
        //킹피셔
        if (gsno(data.userimg) == "0") {
            profileImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
        } else {
            if let url = URL(string: gsno(data.userimg)){
                
                self.profileImgView.kf.setImage(with: url)
            }
        }
      
      //  self.contentView.addSubview(self.contentImgView)
//        //이미지
    /*    if (gsno(data.img) != ""){
//            if let url = URL(string: gsno(data.img)){
//                //self.contentImgView.kf.setImage(with: url)
//
//                //contentImgView.image = #imageLiteral(resourceName: "dabi")
//            }
            let url = URL(string: gsno(data.img))
            contentImgView.kf.setImage(with: url)
         
          
        }*/
        if (gsno(data.img) == "0") {
           // if (contentImgView != nil ) {
           //     contentImgView.removeFromSuperview()
           // }
            contentImgView.image = #imageLiteral(resourceName: "dabi")
      // self.contentView.viewWithTag(-1)?.removeFromSuperview()
        } else {
             if let url = URL(string: gsno(data.img)){
                self.contentImgView.kf.setImage(with: url)
            }
        }
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

        contentImgView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped(sender:)))
        tap.numberOfTapsRequired = 2
        contentImgView.addGestureRecognizer(tap)
    
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc func imgTap(sender: UITapGestureRecognizer) {
        delegate?.myTableDelegate(index : index)
        
    }
    @objc func lblTap(sender: UITapGestureRecognizer) {
        delegate?.myTableDelegate(index : index)
    }
    
    @objc func doubleTapped(sender : UITapGestureRecognizer) {
         doubleTapdelegate?.myDoubleTapDelegate(sender : sender)
    }
    
}

