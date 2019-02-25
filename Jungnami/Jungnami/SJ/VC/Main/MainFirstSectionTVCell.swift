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
    func configure(first : Legislator, second : Legislator){

        setImageView(imgView: firstImgView, imgUrl: first.profileImg)
        firstNameLbl.text = first.legiName
        firstPartyLbl.text = first.partyCD?.partyName
        firstProgressBarLbl.text = (first.voteCnt ?? 0).description + "표"
        guard let firstPartyCd = first.partyCD, let secPartyCd = second.partyCD else {return}
        setProgressbarColor(progressbar: firstProgressBar, partyCode: firstPartyCd)
        setProgresssbarWidth(progressbar: firstProgressBar, progressWidth: first.ratio ?? 0.0)

        setImageView(imgView: secondImgView, imgUrl: second.profileImg)
        secondNameLbl.text = second.legiName
        secondPartyLbl.text = second.partyCD?.partyName
        secondProgressBarLbl.text = (second.voteCnt ?? 0).description + "표"
        setProgressbarColor(progressbar: secondProgressBar, partyCode: secPartyCd)
        setProgresssbarWidth(progressbar: secondProgressBar, progressWidth: second.ratio ?? 0.0)
    }
    
    func setImageView(imgView : UIImageView, imgUrl : String?){
        if let imgUrl = imgUrl , let url = URL(string : imgUrl) {
             imgView.kf.setImage(with: url)
        } else {
             imgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
        }
    }
    
    func setProgresssbarWidth(progressbar : UIView, progressWidth : Double){
        progressbar.snp.makeConstraints { (make) in
            make.width.equalTo(maxWidth*progressWidth/100)
        }
    }
    
    func setProgressbarColor(progressbar : UIView, partyCode : PartyCode){
        progressbar.backgroundColor = partyCode.partyColor
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
