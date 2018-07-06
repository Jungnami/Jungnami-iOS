//
//  MainTVCell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 6..
//

import UIKit

class MainTVCell: UITableViewCell {

    @IBOutlet weak var rankLbl: UILabel!
    @IBOutlet weak var medalImgView: UIImageView! //
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var progressBar: UIView! //
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var partyLbl: UILabel!
    @IBOutlet weak var voteCountLbl: UILabel!
    
    @IBOutlet weak var voteBtn: UIButton!
    
    let maxWidth : Double = 240.0
    func configure(viewType : MainViewType, index : Int, data : SampleMain){
        rankLbl.text = "\(data.rank)"
        profileImgView.image = data.profile
        nameLbl.text = data.name
        partyLbl.text = "_\(data.party.rawValue)"
        voteCountLbl.text = "\(data.voteCount)"
        
        profileImgView.makeImageRound()
        progressBar.snp.makeConstraints { (make) in
            make.width.equalTo(maxWidth*data.rate)
        }
        
        progressBar.makeRounded()
       
        switch viewType {
        case .like:
            if data.rank == 1 {
                medalImgView.image = #imageLiteral(resourceName: "ranking_gold_medal")
            } else if data.rank == 2 {
                medalImgView.image = #imageLiteral(resourceName: "ranking_silver_medal")
            } else if data.rank == 3 {
                medalImgView.image = #imageLiteral(resourceName: "ranking_bronze_medal")
            }
        case .dislike :
            if data.rank == 1 {
                medalImgView.image = #imageLiteral(resourceName: "ranking_red_bomb")
            } else if data.rank == 2 {
                medalImgView.image = #imageLiteral(resourceName: "ranking_orange_bomb")
            } else if data.rank == 3 {
                medalImgView.image = #imageLiteral(resourceName: "ranking_yellow_bomb")
            }
        }
        
        
        if index > 2 {
            medalImgView.isHidden = true
        }
        
        if(index % 2 == 1){
            self.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9843137255, alpha: 1)
        }
        
        
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImgView.layer.borderColor = ColorChip.shared().mainColor.cgColor
        profileImgView.layer.borderWidth = 2
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

