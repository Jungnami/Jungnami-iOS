//
//  MyPageVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 4..
//

import UIKit

class MyPageVC: UIViewController {

    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var profileuserNameLbl: UILabel!
    
    @IBOutlet weak var profileScrapNumLbl: UILabel!
    @IBOutlet weak var profileMyfeedNumLbl: UILabel!
    @IBOutlet weak var profileFollowingNumLbl: UILabel!
    @IBOutlet weak var profileFollowerNumLbl: UILabel!
    
    @IBOutlet weak var profileCoinCountLbl: UILabel!
    @IBOutlet weak var profileVoteCountLbl: UILabel!
    
    //알림, 설정, 버튼으로 연결해야함
    var data = MyPageData.sharedInstance.myPageUsers
    func configure(data: MyPageSample) {
        profileImgView.image = data.profileImg
        self.profileImgView.layer.cornerRadius = self.profileImgView.layer.frame.size.width / 2
        profileuserNameLbl.text = data.userId
        profileScrapNumLbl.text = data.scrapCount
        profileMyfeedNumLbl.text = data.scrapCount
        profileFollowerNumLbl.text = data.followerCount
        profileFollowingNumLbl.text = data.followCount
        profileCoinCountLbl.text = data.coin
        profileVoteCountLbl.text = data.vote
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.profileImgView.layer.cornerRadius = self.profileImgView.layer.frame.size.width / 2
        configure(data: data[1])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
