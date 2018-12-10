//
//  MypageHeaderView.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 8. 6..
//

import UIKit

class MypageHeaderView: UIView {
    @IBOutlet weak var myInfoView: UIView!
    @IBOutlet weak var containScarpFeedView: UIView!
    @IBOutlet var myCoinView: UIView!
    @IBOutlet var myVoteView: UIView!
    
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var profileuserNameLbl: UILabel!
    @IBOutlet weak var profileScrapNumLbl: UILabel!
    @IBOutlet weak var profileMyfeedNumLbl: UILabel!
    @IBOutlet weak var profileFollowingNumLbl: UILabel!
    @IBOutlet weak var profileFollowerNumLbl: UILabel!
    @IBOutlet weak var profileCoinCountLbl: myTouchLbl!
    @IBOutlet weak var profileVoteCountLbl: myTouchLbl!
    
    
    
    @IBOutlet weak var alarmBtn: UIButton!
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var alarmCountLbl: UILabel!
    @IBOutlet weak var alarmBG: UIImageView!
    
    class func instanceFromNib() -> MypageHeaderView {
        
        
        return UINib(nibName: "MypageHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MypageHeaderView
    }

}
