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
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var scapBtn: UIButton!
    @IBOutlet weak var feedBtn: UIButton!
    
    //알림, 설정, 버튼으로 연결해야함
    var data = MyPageData.sharedInstance.myPageUsers
    
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
    func configure(data: MyPageSample) {
        profileImgView.image = data.profileImg
        profileImgView.makeImageRound()
        profileuserNameLbl.text = data.userId
        profileScrapNumLbl.text = data.scrapCount
        profileMyfeedNumLbl.text = data.feedCount
        profileFollowerNumLbl.text = data.followerCount
        profileFollowingNumLbl.text = data.followCount
        profileCoinCountLbl.text = data.coin
        profileVoteCountLbl.text = data.vote
    }
    
    
    @IBAction func changeView(_ sender: UIButton) {
        updateView(selected: sender.tag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.profileImgView.layer.cornerRadius = self.profileImgView.layer.frame.size.width / 2
        configure(data: data[1])
        updateView(selected: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//메뉴바랑 그 안 컨테이너뷰
extension MyPageVC{
    
    static func viewController() -> MyPageVC {
        return UIStoryboard.init(name: "Sub", bundle: nil).instantiateViewController(withIdentifier: MyPageVC.reuseIdentifier) as! MyPageVC
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
        scapBtn.setTitleColor(ColorChip.shared().mainColor, for: .normal)

            feedBtn.setTitleColor(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1), for: .normal)
        
            remove(asChildViewController: myFeedVC)
            add(asChildViewController: scrapCVC)
        } else {
            feedBtn.setTitleColor(ColorChip.shared().mainColor, for: .normal)
          
            scapBtn.setTitleColor(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1), for: .normal)
          
            remove(asChildViewController: scrapCVC)
            add(asChildViewController: myFeedVC)
        }
    }
    
    
    
}
