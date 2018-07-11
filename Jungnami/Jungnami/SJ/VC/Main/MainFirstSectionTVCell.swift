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
    func configure(first : LegislatorLikeVOData, second : LegislatorLikeVOData){
        firstImgView.image = #imageLiteral(resourceName: "inni")
        firstNameLbl.text = first.lName
        firstPartyLbl.text = first.partyName.rawValue
        firstProgressBarLbl.text = first.scoretext
        switch first.partyName {
        case .더불어민주당:
             firstProgressBar.backgroundColor = ColorChip.shared().partyBlue
        case .자유한국당:
            firstProgressBar.backgroundColor = ColorChip.shared().partyRed
        case .민중당:
            firstProgressBar.backgroundColor = ColorChip.shared().partyOrange
        case .바른미래당:
            firstProgressBar.backgroundColor = ColorChip.shared().partyMint
        case .무소속:
            firstProgressBar.backgroundColor = ColorChip.shared().partyGray
        case .대한애국당:
            firstProgressBar.backgroundColor = ColorChip.shared().partyNavy
        case .민주평화당:
            firstProgressBar.backgroundColor = ColorChip.shared().partyGreen
        case .정의당:
            firstProgressBar.backgroundColor = ColorChip.shared().partyYellow
        }
    
        firstProgressBar.snp.makeConstraints { (make) in
            make.width.equalTo(maxWidth*first.width)
        }
        secondImgView.image = #imageLiteral(resourceName: "dabi")
        secondNameLbl.text = second.lName
        secondPartyLbl.text = second.partyName.rawValue
        secondProgressBarLbl.text = second.scoretext
        switch second.partyName {
        case .더불어민주당:
            secondProgressBar.backgroundColor = ColorChip.shared().partyBlue
        case .자유한국당:
            secondProgressBar.backgroundColor = ColorChip.shared().partyRed
        case .민중당:
            secondProgressBar.backgroundColor = ColorChip.shared().partyOrange
        case .바른미래당:
            secondProgressBar.backgroundColor = ColorChip.shared().partyMint
        case .무소속:
            secondProgressBar.backgroundColor = ColorChip.shared().partyGray
        case .대한애국당:
            secondProgressBar.backgroundColor = ColorChip.shared().partyNavy
        case .민주평화당:
            secondProgressBar.backgroundColor = ColorChip.shared().partyGreen
        case .정의당:
            secondProgressBar.backgroundColor = ColorChip.shared().partyYellow
        }
        secondProgressBar.snp.makeConstraints { (make) in
            make.width.equalTo(maxWidth*second.width)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        firstProgressBar.makeRounded()
        secondProgressBar.makeRounded()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        firstProgressBar.isHidden = false
        secondProgressBar.isHidden = false
    }
    
}
