//
//  CommunityResultTVCell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 11..
//

import UIKit
import Kingfisher
import SnapKit


class CommunityResultTVCell: UITableViewCell {
    
    @IBOutlet weak var profileImgView: myTouchImg!
    @IBOutlet weak var nameLabel: myTouchLbl!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var contentImgView : UIImageView!
    @IBOutlet weak var heartBtn : myHeartBtn!
    @IBOutlet weak var commentBtn : myCommentBtn!
    @IBOutlet weak var scrapBtn : UIButton!
    
    var delegate: TapDelegate2?
    var doubleTapdelegate: DoubleTapDelegate?

    var index : Int = 0
    func configure(index : Int, data : CommunitySearchVOData){
        self.index = index
        
        commentBtn.commentCnt = data.commentcnt
        commentBtn.likeCnt = data.likecnt
        heartBtn.setImage(UIImage(named: "community_heart"), for: .normal)
        heartBtn.setImage(UIImage(named: "community_heart_blue"), for: .selected)
        heartBtn.likeCnt = data.likecnt
        nameLabel.text = data.nickname
        timeLabel.text = data.writingtime
        contentLabel.text = data.content
        contentLabel.sizeToFit()
        likeLabel.text = "\(data.likecnt)"
        commentLabel.text = "\(data.commentcnt)"
        //고치기 - 유저 아이디
        nameLabel.userId = "\(data.id)"
        profileImgView.userId = "\(data.id)"
        if data.islike == 0 {
            heartBtn.isSelected = false
        } else {
            heartBtn.isSelected = true
        }
        //킹피셔
        if (gsno(data.userImgURL) == "0") {
            profileImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
        } else {
            if let url = URL(string: gsno(data.userImgURL)){
                
                self.profileImgView.kf.setImage(with: url)
            }
        }
      
        if (gsno(data.imgURL) == "0") {
           
            contentImgView.image = #imageLiteral(resourceName: "dabi")
           
        } else {
            if let url = URL(string: gsno(data.imgURL)){
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
          delegate?.myTableDelegate(sender : sender)
        
    }
    @objc func lblTap(sender: UITapGestureRecognizer) {
          delegate?.myTableDelegate(sender : sender)
    }
    
    @objc func doubleTapped(sender : UITapGestureRecognizer) {
        doubleTapdelegate?.myDoubleTapDelegate(sender : sender)
    }
    
}

