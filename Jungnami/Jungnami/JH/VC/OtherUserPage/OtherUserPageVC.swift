//
//  OtherUserPage.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 7..
//

import UIKit

class OtherUserPageVC: UIViewController {

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
    
    
    @IBOutlet weak var containerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        otherUserImgView.makeRounded()
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
//extension OtherUserPageVC{
//    
//    
//    static func viewController() -> MyFeedVC {
//        return UIStoryboard.init(name: "Sub", bundle: nil).instantiateViewController(withIdentifier: MyFeedVC.reuseIdentifier) as! MyFeedVC
//    }
//    
//    
//    
//    private func add(asChildViewController viewController: UIViewController) {
//        
//        // Add Child View Controller
//        addChildViewController(viewController)
//        
//        // Add Child View as Subview
//        containerView.addSubview(viewController.view)
//        
//        // Configure Child View
//        viewController.view.frame = containerView.bounds
//        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        
//        // Notify Child View Controller
//        viewController.didMove(toParentViewController: self)
//    }
//    
//    //----------------------------------------------------------------
//    
//    private func remove(asChildViewController viewController: UIViewController) {
//        // Notify Child View Controller
//        viewController.willMove(toParentViewController: nil)
//        
//        // Remove Child View From Superview
//        viewController.view.removeFromSuperview()
//        
//        // Notify Child View Controller
//        viewController.removeFromParentViewController()
//    }
//    
//    //----------------------------------------------------------------
//    
//    private func updateView(selected : Int) {
//        if selected == 0 {
//            scapBtn.setTitleColor(ColorChip.shared().mainColor, for: .normal)
//            
//            feedBtn.setTitleColor(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1), for: .normal)
//            
//            remove(asChildViewController: myFeedVC)
//            add(asChildViewController: scrapCVC)
//        } else {
//            feedBtn.setTitleColor(ColorChip.shared().mainColor, for: .normal)
//            
//            scapBtn.setTitleColor(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1), for: .normal)
//            
//            remove(asChildViewController: scrapCVC)
//            add(asChildViewController: myFeedVC)
//        }
//    }
//    
//    
//    
//}
