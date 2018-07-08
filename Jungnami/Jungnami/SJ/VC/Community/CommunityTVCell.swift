//
//  CommunityTVCell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 2..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class CommunityTVCell: UITableViewCell {

    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var contentImgView : UIImageView!
    @IBOutlet weak var heartBtn : UIButton!
    @IBOutlet weak var commentBtn : UIButton!
    @IBOutlet weak var scrapBtn : UIButton!
    
    var delegate: TapDelegate?

    var index : Int = 0

    /////////////////////샘플설정///////////////////////////////
    func configure(index : Int, data : Sample){
        self.index = index
       
        profileImgView.image = data.profileUrl
        nameLabel.text = data.name
        timeLabel.text = data.time
        contentLabel.text = data.content
        contentLabel.sizeToFit()
        likeLabel.text = "\(data.like)"
        commentLabel.text = "\(data.comment)"
        if data.heart {
            heartBtn.setImage(#imageLiteral(resourceName: "community_heart"), for: .normal)
        } else {
            heartBtn.setImage(#imageLiteral(resourceName: "community_heart_blue"), for: .normal)
        }
        if data.scrap {
            scrapBtn.setImage(#imageLiteral(resourceName: "community_scrap"), for: .normal)
        } else {
            scrapBtn.setImage(#imageLiteral(resourceName: "community_scrap_blue"), for: .normal)
        }

        
        if data.contentImg != nil {
            contentImgView.image = data.contentImg
        } else {
            self.contentView.viewWithTag(-1)?.removeFromSuperview()
        }
    }
    ////////////////////////////////////////////////////
    
    
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

}

