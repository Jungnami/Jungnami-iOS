//
//  MainFirstSectionTVCell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 6..
//

import UIKit
import SnapKit
class MainFirstSectionTVCell: UITableViewCell {
    
    @IBOutlet weak var firstImgView: UIImageView!
    @IBOutlet weak var secondImgView: UIImageView!
    
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var secondNameLbl: UILabel!
    @IBOutlet weak var firstPartyLbl: UILabel!
    @IBOutlet weak var secondPartyLbl: UILabel!
    
    @IBOutlet weak var firstProgressBar: UIView!
    
    @IBOutlet weak var secondProgressBar: UIView!
    
    @IBOutlet weak var firstProgressBarLbl: UILabel!
    @IBOutlet weak var secondProgressBarLbl: UILabel!
    let maxWidth : Double = 150.0
    //꽉찬게 240
    func configure(first : SampleMain, second : SampleMain){
        firstImgView.image = first.profile
        firstNameLbl.text = first.name
        firstPartyLbl.text = first.party.rawValue
        firstProgressBarLbl.text = "\(first.voteCount)표"
        switch first.party {
        case .blue:
             firstProgressBar.backgroundColor = ColorChip.shared().partyBlue
        case .yellow:
            firstProgressBar.backgroundColor = ColorChip.shared().partyYellow
        case .mint:
            firstProgressBar.backgroundColor = ColorChip.shared().partyMint
        case .red:
            firstProgressBar.backgroundColor = ColorChip.shared().partyRed
        case .orange:
            firstProgressBar.backgroundColor = ColorChip.shared().partyOrange
        }
        
        firstProgressBar.snp.makeConstraints { (make) in
            make.width.equalTo(maxWidth*first.rate)
        }
        secondImgView.image = second.profile
        secondNameLbl.text = second.name
        secondPartyLbl.text = second.party.rawValue
        secondProgressBarLbl.text = "\(second.voteCount)표"
        switch second.party {
        case .blue:
            secondProgressBar.backgroundColor = ColorChip.shared().partyBlue
        case .yellow:
            secondProgressBar.backgroundColor = ColorChip.shared().partyYellow
        case .mint:
            secondProgressBar.backgroundColor = ColorChip.shared().partyBlue
        case .red:
            secondProgressBar.backgroundColor = ColorChip.shared().partyRed
        case .orange:
            secondProgressBar.backgroundColor = ColorChip.shared().partyOrange
        }
        secondProgressBar.snp.makeConstraints { (make) in
            make.width.equalTo(maxWidth*second.rate)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //왼쪽 바 둥글게
        let leftRectShape = CAShapeLayer()
        leftRectShape.bounds = self.firstProgressBar.frame
        leftRectShape.position = self.firstProgressBar.center
        leftRectShape.path = UIBezierPath(roundedRect: self.firstProgressBar.bounds, byRoundingCorners: [.topRight , .bottomRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
        self.firstProgressBar.layer.mask = leftRectShape
        
        //오른쪽 바 둥글게
        let rightRectShape = CAShapeLayer()
        rightRectShape.bounds = self.secondProgressBar.frame
        rightRectShape.position = self.secondProgressBar.center
        rightRectShape.path = UIBezierPath(roundedRect: self.secondProgressBar.bounds, byRoundingCorners: [.topLeft , .bottomLeft], cornerRadii: CGSize(width: 20, height: 20)).cgPath
        self.secondProgressBar.layer.mask = rightRectShape
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        firstProgressBar.isHidden = false
        secondProgressBar.isHidden = false
    }
    
}
