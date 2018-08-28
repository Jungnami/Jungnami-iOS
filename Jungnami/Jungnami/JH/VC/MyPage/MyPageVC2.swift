//
////
////  MyPageVC.swift
////  Jungnami
////
////  Created by 이지현 on 2018. 7. 4..
////
//
////지우고 정리
//
//import UIKit
//import Kingfisher
//
//class MyPageVC2: UIViewController , APIService{
//    @IBOutlet weak var myInfoView: UIView!
//    @IBOutlet weak var containScarpFeedView: UIView!
//    @IBOutlet var myCoinView: UIView!
//    @IBOutlet var myVoteView: UIView!
//
//    @IBOutlet weak var profileImgView: UIImageView!
//    @IBOutlet weak var profileuserNameLbl: UILabel!
//    @IBOutlet weak var profileScrapNumLbl: UILabel!
//    @IBOutlet weak var profileMyfeedNumLbl: UILabel!
//    @IBOutlet weak var profileFollowingNumLbl: UILabel!
//    @IBOutlet weak var profileFollowerNumLbl: UILabel!
//    @IBOutlet weak var profileCoinCountLbl: myTouchLbl!
//    @IBOutlet weak var profileVoteCountLbl: myTouchLbl!
//    @IBOutlet weak var containerView: UIView!
//
//    @IBOutlet weak var scapBtn: UIButton!
//    @IBOutlet weak var feedBtn: UIButton!
//
//
//    @IBOutlet weak var alarmBtn: UIButton!
//
//    @IBOutlet weak var alarmCountLbl: UILabel!
//    @IBOutlet weak var alarmBG: UIImageView!
//
//    @IBAction func dismissBtn(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    @IBAction func changeView(_ sender: UIButton) {
//        updateView(selected: sender.tag)
//    }
//
//
//    func getAlarm(alarmCount: Int) {
//        if alarmCount == 0 {
//            alarmCountLbl.isHidden = true
//            alarmBG.isHidden = true
//        } else {
//            alarmCountLbl.isHidden = false
//            alarmBG.isHidden = false
//            if alarmCount > 99 {
//                alarmCountLbl.text = "99+"
//            } else {
//                alarmCountLbl.text = "\(alarmCount)"
//            }
//
//        }
//    }
//
//    //알림, 설정, 버튼으로 연결해야함
//    //var data = MyPageData.sharedInstance.myPageUsers
//    //tapGesture--------------------------------
//    var keyboardDismiss: UITapGestureRecognizer?
//   // var delegate : TapDelegate2?
//    //    var index = 0
//    //셀아닌부분에서 tapGesture하려면 어떻게...?
//    //------------------------------------------
//
//    var myBoardData : [MyPageVODataBoard]  = [] {
//        didSet {
//            myFeedVC.myBoardData = myBoardData
//        }
//    }
//    var myScrapData : [MyPageVODataScrap]  = [] {
//        didSet {
//            scrapCVC.myScrapData = myScrapData
//        }
//    }
//
//    var selectedUserId : String?
//
//    private lazy var scrapCVC: ScrapCVC = {
//
//        let storyboard = UIStoryboard(name: "Sub", bundle: Bundle.main)
//
//        var viewController = storyboard.instantiateViewController(withIdentifier: ScrapCVC.reuseIdentifier) as! ScrapCVC
//
//
//        self.add(asChildViewController: viewController)
//
//        return viewController
//    }()
//
//    private lazy var myFeedVC: MyFeedVC = {
//
//        let storyboard = UIStoryboard(name: "Sub", bundle: Bundle.main)
//
//        var viewController = storyboard.instantiateViewController(withIdentifier: MyFeedVC.reuseIdentifier) as! MyFeedVC
//        viewController.myBoardData = self.myBoardData
//        self.add(asChildViewController: viewController)
//
//        return viewController
//    }()
//
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if let selectedUserId_ = selectedUserId {
//            getMyPage(url: url("/user/mypage/\(selectedUserId_)"))
//        }
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        profileImgView.makeImageRound()
//        self.alarmBtn.addTarget(self, action:  #selector(toAlarmVC(_sender:)), for: .touchUpInside)
//        updateView(selected: 0)
//
//        //네비게이션바 히든
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
//
//        //make label button
//        let tapFollow = UITapGestureRecognizer(target: self, action: #selector(MyPageVC2.tapFollowLbl(_:)))
//        profileFollowingNumLbl.isUserInteractionEnabled = true
//        profileFollowingNumLbl.addGestureRecognizer(tapFollow)
//
//        let tapFollower = UITapGestureRecognizer(target: self, action: #selector(MyPageVC2.tapFollowerLbl(_:)))
//        profileFollowerNumLbl.isUserInteractionEnabled = true
//        profileFollowerNumLbl.addGestureRecognizer(tapFollower)
//        if let selectedUserId_ = selectedUserId {
//             getMyPage(url: url("/user/mypage/\(selectedUserId_)"))
//        }
//
//        let tapAction1 = UITapGestureRecognizer(target: self, action: #selector(self.actionTapped(_:)))
//        let tapAction2 = UITapGestureRecognizer(target: self, action: #selector(self.actionTapped(_:)))
//        profileCoinCountLbl?.isUserInteractionEnabled = true
//        profileCoinCountLbl?.addGestureRecognizer(tapAction1)
//        profileVoteCountLbl?.isUserInteractionEnabled = true
//        profileVoteCountLbl?.addGestureRecognizer(tapAction2)
//
//    }
//
//    @objc func actionTapped(_ sender: UITapGestureRecognizer) {
//        if let chargeVC = Storyboard.shared().subStoryboard.instantiateViewController(withIdentifier:ChargeVC.reuseIdentifier) as? ChargeVC {
//
//            self.present(chargeVC, animated: true, completion: nil)
//        }
//    }
//
//    //followLbl 터치했을 때 화면 올리기
//    @objc func tapFollowLbl(_ sender: UITapGestureRecognizer) {
//
//
//        if let followListVC = Storyboard.shared().subStoryboard.instantiateViewController(withIdentifier:FollowListVC.reuseIdentifier) as? FollowListVC {
//            followListVC.selectedUserId = selectedUserId
//            followListVC.entryPoint = 0
//            followListVC.navTitle = "팔로잉"
//            self.present(followListVC, animated: true, completion: nil)
//        }
//    }
//    //followerLbl 터치했을 때 화면 올리기
//    @objc func tapFollowerLbl(_ sender: UITapGestureRecognizer) {
//        if let followListVC = Storyboard.shared().subStoryboard.instantiateViewController(withIdentifier:FollowListVC.reuseIdentifier) as? FollowListVC {
//            followListVC.selectedUserId = selectedUserId
//            followListVC.entryPoint = 1
//            followListVC.navTitle = "팔로워"
//            self.present(followListVC, animated: true, completion: nil)
//        }
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//
//    }
//}
//
////메뉴바랑 그 안 컨테이너뷰
//extension MyPageVC2{
//
//    static func viewController() -> MyPageVC {
//        return Storyboard.shared().mypageStoryboard.instantiateViewController(withIdentifier: MyPageVC.reuseIdentifier) as! MyPageVC
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
////알림페이지로 가게
//extension MyPageVC2 {
//    @objc func toAlarmVC(_sender: UIButton){
//        if let noticeVC = Storyboard.shared().subStoryboard.instantiateViewController(withIdentifier:NoticeVC.reuseIdentifier) as? NoticeVC {
//
//            let myId = UserDefaults.standard.string(forKey: "userIdx") ?? "-1"
//            if (myId == "-1"){
//                self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
//                    if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
//                        loginVC.entryPoint = 1
//                        self.present(loginVC, animated: true, completion: nil)
//                    }
//                })
//
//            } else {
//                self.present(noticeVC, animated : true)
//            }
//
//        }
//    }
//}
//
////통신
//
//extension MyPageVC2 {
//    func getMyPage(url : String) {
//        MypageService.shareInstance.getUserPage(url: url, completion: { [weak self] (result) in
//            guard let `self` = self else { return }
//
//            switch result {
//            case .networkSuccess(let myPageData):
//
//
//                let myPageData = myPageData as! MyPageVOData
//                if (self.gsno(myPageData.img) == "0") {
//                    self.profileImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
//                } else {
//                    if let url = URL(string: self.gsno(myPageData.img)){
//                        self.profileImgView.kf.setImage(with: url)
//                    }
//                }
//                self.profileuserNameLbl.text = myPageData.nickname
//                self.profileScrapNumLbl.text = "\(myPageData.scrapcnt)"
//                self.profileMyfeedNumLbl.text = "\(myPageData.boardcnt)"
//                self.profileFollowingNumLbl.text = "\(myPageData.followingcnt)"
//                self.profileFollowerNumLbl.text = "\(myPageData.followercnt)"
//                self.profileCoinCountLbl.text = "\(myPageData.coin)"
//                self.profileVoteCountLbl.text = "\(myPageData.votingcnt)"
//                self.myBoardData = myPageData.board
//                self.myScrapData = myPageData.scrap
//                self.getAlarm(alarmCount: myPageData.pushcnt)
//                break
//            case .nullValue :
//                self.simpleAlert(title: "오류", message: "값 없음")
//            case .networkFail :
//                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
//            default :
//                break
//            }
//
//        })
//    }
//}
//
//