//
//  OtherUserPage.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 7..
//

import UIKit

class OtherUserPage: UIViewController {

    @IBOutlet weak var otherUserImgView: UIView!
    @IBOutlet weak var otherUserNameLbl: UILabel!
    @IBAction func otherUserFollowBtn(_ sender: Any) {
        //
    }
    @IBOutlet weak var otherUserScrapCountLbl: UILabel!
    @IBOutlet weak var otherUserFeedCountLbl: UILabel!
    @IBOutlet weak var otherUserFollowingCountLbl: UILabel!
    @IBOutlet weak var otherUserFollowerCountLbl: UILabel!
    //containerView changeBtn
    @IBAction func otherUserScrapBtn(_ sender: Any) {
    }
    //containerView changeFeedBtn
    @IBAction func otherUserFeedBtn(_ sender: Any) {
    }
    //alarmBtn
    @IBAction func otherUserAlarmBtn(_ sender: Any) {
        
    }
    @IBOutlet weak var otherUserAlarmCountLbl: UILabel!
    
    //backBtn
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        otherUserImgView.layer.cornerRadius = otherUserImgView.layer.frame.width/2
        otherUserImgView.layer.borderWidth = 1
        otherUserImgView.layer.borderColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
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
