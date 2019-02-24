//
//  PartyListDetailTVcell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 5..
//

import UIKit
import Kingfisher

class PartyListDetailTVcell: UITableViewCell {
    
    @IBOutlet weak var indexLbl: UILabel!
    
    @IBOutlet weak var profileImgView: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var rankLbl: UILabel!
    
    @IBOutlet weak var regionLbl: UILabel!
    @IBOutlet weak var likeBtn: UIButton!
    func configure(index : Int, data : CategorizedLegislator){
        //고치기
        //indexLbl.text = "\(data.rank)"
        
        if let imgUrl = data.profileImg, let url = URL(string : imgUrl){
            self.profileImgView.kf.setImage(with: url)
        } else {
             profileImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
        }
      
        nameLbl.text = data.legiName
        //고치기
        //rankLbl.text = data.rankInAll
        regionLbl.text = data.region
        profileImgView.layer.borderColor = data.partyCD?.partyColor.cgColor
        
        if index % 2 == 1 {
            self.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        } else {
            self.backgroundColor = .white
        }
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImgView.makeImageRound()
        profileImgView.layer.borderWidth = 2
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
