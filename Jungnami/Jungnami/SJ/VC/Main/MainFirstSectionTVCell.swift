//
//  MainFirstSectionTVCell.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 6..
//

import UIKit
import SnapKit
import Kingfisher

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

        setImageView(imgView: firstImgView, imgUrl: first.mainimg)
        firstNameLbl.text = first.lName
        firstPartyLbl.text = first.partyName.rawValue
        firstProgressBarLbl.text = first.scoretext
        setProgressbarColor(progressbar: firstProgressBar, partyName: first.partyName)
        setProgresssbarWidth(progressbar: firstProgressBar, progressWidth: first.width)

        setImageView(imgView: secondImgView, imgUrl: second.mainimg)
        secondNameLbl.text = second.lName
        secondPartyLbl.text = second.partyName.rawValue
        secondProgressBarLbl.text = second.scoretext
        setProgressbarColor(progressbar: secondProgressBar, partyName: second.partyName)
        setProgresssbarWidth(progressbar: secondProgressBar, progressWidth: second.width)
    }
    
    func setImageView(imgView : UIImageView, imgUrl : String?){
        if (gsno(imgUrl) == "0") {
            imgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
        } else {
            if let url = URL(string: gsno(imgUrl)){
                imgView.kf.setImage(with: url)
            }
        }
    }
    func setProgresssbarWidth(progressbar : UIView, progressWidth : Double){
        progressbar.snp.makeConstraints { (make) in
            make.width.equalTo(maxWidth*progressWidth)
        }
    }
    
    func setProgressbarColor(progressbar : UIView, partyName : PartyName){
        switch partyName {
        case .더불어민주당:
            progressbar.backgroundColor = ColorChip.shared().partyBlue
        case .자유한국당:
            progressbar.backgroundColor = ColorChip.shared().partyRed
        case .민중당:
            progressbar.backgroundColor = ColorChip.shared().partyOrange
        case .바른미래당:
            progressbar.backgroundColor = ColorChip.shared().partyMint
        case .무소속:
            progressbar.backgroundColor = ColorChip.shared().partyGray
        case .대한애국당:
            progressbar.backgroundColor = ColorChip.shared().partyNavy
        case .민주평화당:
            progressbar.backgroundColor = ColorChip.shared().partyGreen
        case .정의당:
            progressbar.backgroundColor = ColorChip.shared().partyYellow
        }
    }
    func setProgressBarWidth(){
        firstProgressBar.removeConstraints()
        secondProgressBar.removeConstraints()
        firstProgressBar.snp.makeConstraints { (make) in
            make.leading.equalTo(firstImgView.snp.leading).offset(-8)
            make.height.equalTo(15)
            make.bottom.equalTo(firstImgView.snp.bottom).offset(-21)
        }
        firstProgressBarLbl.snp.makeConstraints { (make) in
            make.trailing.equalTo(firstProgressBar.snp.trailing).offset(-8)
            make.centerY.equalTo(firstProgressBar)
        }
        
        secondProgressBar.snp.makeConstraints { (make) in
            make.trailing.equalTo(secondImgView.snp.trailing).offset(8)
            make.height.equalTo(15)
            make.bottom.equalTo(secondImgView.snp.bottom).offset(-21)
        }
        secondProgressBarLbl.snp.makeConstraints { (make) in
            make.leading.equalTo(secondProgressBar.snp.leading).offset(8)
            make.centerY.equalTo(secondProgressBar)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        firstProgressBar.makeRounded()
        secondProgressBar.makeRounded()
    }

    override func prepareForReuse() {
        setProgressBarWidth()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        firstProgressBar.isHidden = false
        secondProgressBar.isHidden = false
    }
    
}
