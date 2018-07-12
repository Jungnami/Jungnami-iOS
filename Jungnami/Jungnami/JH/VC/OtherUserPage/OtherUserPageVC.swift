//
//  OtherUserPage.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 7..
//

import UIKit

class OtherUserPageVC: UIViewController {

    @IBOutlet weak var otherUserProfileImgView: UIImageView!
    @IBOutlet weak var otherUserNameLbl: UILabel!
    @IBAction func otherUserFollowBtn(_ sender: Any) {
        //
    }
    @IBOutlet weak var otherUserScrapCountLbl: UILabel!
    @IBOutlet weak var otherUserFeedCountLbl: UILabel!
    @IBOutlet weak var otherUserFollowingCountLbl: UILabel!
    @IBOutlet weak var otherUserFollowerCountLbl: UILabel!
    
    
    
    //containerView changeBtn ->
    @IBOutlet weak var otherUserScrapBtn: UIButton!
    @IBOutlet weak var otherUserFeedBtn: UIButton!
    
    //backBtn
    
    @IBOutlet weak var dismissBtn: UIButton!
    @IBAction func dismissBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBOutlet weak var containerView: UIView!
    @IBAction func changeView(_ sender: UIButton) {
        
        updateView(selected: sender.tag)
        
    }
    //tapGesture-------------------------------
    var keyboardDismiss: UITapGestureRecognizer?
    var delegate : TapDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        otherUserProfileImgView.makeRounded()
        updateView(selected: 0)
        //tapGesture
        //make label button
        let tapFollow = UITapGestureRecognizer(target: self, action: #selector(OtherUserPageVC.tapFollowLbl(_:)))
        otherUserFollowingCountLbl.isUserInteractionEnabled = true
        otherUserFollowingCountLbl.addGestureRecognizer(tapFollow)
        
        let tapFollower = UITapGestureRecognizer(target: self, action: #selector(OtherUserPageVC.tapFollowerLbl(_:)))
        otherUserFollowerCountLbl.isUserInteractionEnabled = true
        otherUserFollowerCountLbl.addGestureRecognizer(tapFollower)
    }
    //tapGesture
    //followLbl 터치했을 때 화면 올리기------------------------------------
    @objc func tapFollowLbl(_ sender: UITapGestureRecognizer) {
        let followList = UIStoryboard(name: "Sub", bundle: nil).instantiateViewController(withIdentifier: FollowListVC.reuseIdentifier) as! FollowListVC
        //데이터 pass하는거 어케하지~?
        self.present(followList, animated: true, completion: nil)
    }
    //followerLbl 터치했을 때 화면 올리기
    @objc func tapFollowerLbl(_ sender: UITapGestureRecognizer) {
//        let followerList = UIStoryboard(name: "Sub", bundle: nil).instantiateViewController(withIdentifier: FollowerListVC.reuseIdentifier) as! FollowerListVC
//        self.present(followerList, animated: true, completion: nil)
    }
    //------------------------------------------------------------

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private lazy var scrapCVC: ScrapCVC = {
        
        let storyboard = UIStoryboard(name: "Sub", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: ScrapCVC.reuseIdentifier) as! ScrapCVC
        
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var myFeedVC: MyFeedVC = {
        
        let storyboard = UIStoryboard(name: "Sub", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: MyFeedVC.reuseIdentifier) as! MyFeedVC
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
}
extension OtherUserPageVC{
    
    
    static func viewController() -> OtherUserPageVC {
        return UIStoryboard.init(name: "Sub", bundle: nil).instantiateViewController(withIdentifier: OtherUserPageVC.reuseIdentifier) as! OtherUserPageVC
    }
    
    
    private func add(asChildViewController viewController: UIViewController) {
        
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        containerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    //----------------------------------------------------------------
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)
        
        // Remove Child View From Superview
        viewController.view.removeFromSuperview()
        
        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
    //----------------------------------------------------------------
    
    private func updateView(selected : Int) {
        if selected == 0 {
            otherUserScrapBtn.setTitleColor(ColorChip.shared().mainColor, for: .normal)
            
            otherUserFeedBtn.setTitleColor(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1), for: .normal)
            
            remove(asChildViewController: myFeedVC)
            add(asChildViewController: scrapCVC)
        } else {
            otherUserFeedBtn.setTitleColor(ColorChip.shared().mainColor, for: .normal)
            
            otherUserScrapBtn.setTitleColor(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1), for: .normal)
            
            remove(asChildViewController: scrapCVC)
            add(asChildViewController: myFeedVC)
        }
    }
    
    
    
}
