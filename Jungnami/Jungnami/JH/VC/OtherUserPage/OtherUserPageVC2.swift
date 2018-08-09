////
////  OtherUserPage.swift
////  Jungnami
////
////  Created by 이지현 on 2018. 7. 7..
////
////지우고 정리
//import UIKit
//import Kingfisher
//
//class OtherUserPageVC2: UIViewController, APIService {
//
//    @IBOutlet weak var otherUserProfileImgView: UIImageView!
//    @IBOutlet weak var otherUserNameLbl: UILabel!
//
//    @IBOutlet weak var otherUserScrapCountLbl: UILabel!
//    @IBOutlet weak var otherUserFeedCountLbl: UILabel!
//    @IBOutlet weak var otherUserFollowingCountLbl: UILabel!
//    @IBOutlet weak var otherUserFollowerCountLbl: UILabel!
//
//
//
//    //containerView changeBtn ->
//    @IBOutlet weak var otherUserScrapBtn: UIButton!
//    @IBOutlet weak var otherUserFeedBtn: UIButton!
//
//    //backBtn
//
//    @IBOutlet weak var dismissBtn: UIButton!
//    @IBAction func dismissBtn(_ sender: Any) {
//        dismiss(animated: true, completion: nil)
//    }
//
//
//
//    @IBOutlet weak var containerView: UIView!
//    @IBAction func changeView(_ sender: UIButton) {
//
//        updateView(selected: sender.tag)
//
//    }
//    //수진 여기 버튼 연결!
//    @IBOutlet weak var otherUserFollowBtn: followBtn!
//
//
//    //알림, 설정, 버튼으로 연결해야함
//    //var data = MyPageData.sharedInstance.myPageUsers
//    //tapGesture--------------------------------
//    var keyboardDismiss: UITapGestureRecognizer?
//    var delegate : TapDelegate?
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
//
//
//        otherUserFollowBtn.setImage(UIImage(named: "other-user-page_add_user"), for: .normal)
//        otherUserFollowBtn.setImage(UIImage(named: "other-user-page_user_blue"), for: .selected)
//        otherUserFollowBtn.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
//
//
//        otherUserProfileImgView.makeImageRound()
//
//        updateView(selected: 0)
//
//        //네비게이션바 히든
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
//
//        //make label button
//        let tapFollow = UITapGestureRecognizer(target: self, action: #selector(MyPageVC2.tapFollowLbl(_:)))
//        otherUserFollowingCountLbl.isUserInteractionEnabled = true
//        otherUserFollowingCountLbl.addGestureRecognizer(tapFollow)
//
//        let tapFollower = UITapGestureRecognizer(target: self, action: #selector(MyPageVC2.tapFollowerLbl(_:)))
//        otherUserFollowerCountLbl.isUserInteractionEnabled = true
//        otherUserFollowerCountLbl.addGestureRecognizer(tapFollower)
//        if let selectedUserId_ = selectedUserId {
//            getMyPage(url: url("/user/mypage/\(selectedUserId_)"))
//        }
//
//    }
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
//    @objc func like(_ sender : followBtn){
//        //통신
//        if sender.isFollow! == "팔로우" {
//            likeAction(url: url("/user/follow"), userIdx : "\(selectedUserId!)", sender : sender )
//        } else {
//            dislikeAction(url: url("/user/unfollow/\(selectedUserId!)"), sender : sender )
//        }
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//
//    }
//}
//extension OtherUserPageVC2{
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
//            otherUserScrapBtn.setTitleColor(ColorChip.shared().mainColor, for: .normal)
//
//            otherUserFeedBtn.setTitleColor(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1), for: .normal)
//
//            remove(asChildViewController: myFeedVC)
//            add(asChildViewController: scrapCVC)
//        } else {
//            otherUserFeedBtn.setTitleColor(ColorChip.shared().mainColor, for: .normal)
//
//            otherUserScrapBtn.setTitleColor(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1), for: .normal)
//
//            remove(asChildViewController: scrapCVC)
//            add(asChildViewController: myFeedVC)
//        }
//    }
//
//
//
//}
//
////알림페이지로 가게
//extension OtherUserPageVC2 {
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
//extension OtherUserPageVC2 {
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
//                    self.otherUserProfileImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
//                } else {
//                    if let url = URL(string: self.gsno(myPageData.img)){
//                        self.otherUserProfileImgView.kf.setImage(with: url)
//                    }
//                }
//                self.otherUserNameLbl.text = myPageData.nickname
//                self.otherUserScrapCountLbl.text = "\(myPageData.scrapcnt)"
//                self.otherUserFeedCountLbl.text = "\(myPageData.boardcnt)"
//                self.otherUserFollowingCountLbl.text = "\(myPageData.followingcnt)"
//                self.otherUserFollowerCountLbl.text = "\(myPageData.followercnt)"
//
//                //isFollow 0 이라는 것은 아직 팔로잉 한 상태가 아니라는 것 => 그러니까 .isSelected = false
//                //isFollow 1 팔로잉을 하고 있다는것 => 그러니까 .isSelected = true
//                if myPageData.isfollow == 0 {
//                    self.otherUserFollowBtn.isSelected = false
//                    self.otherUserFollowBtn.isFollow = "팔로우"
//                }  else {
//                    self.otherUserFollowBtn.isSelected = true
//                    self.otherUserFollowBtn.isFollow = "팔로잉"
//                }
//                self.myBoardData = myPageData.board
//                self.myScrapData = myPageData.scrap
//
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
//
//}
//
//
//
////통신
//extension OtherUserPageVC2 {
//    //하트 버튼 눌렀을 때
//    func likeAction(url : String, userIdx : String, sender : followBtn){
//
//        let params : [String : Any] = [
//            "following_id" : userIdx
//        ]
//        CommunityLikeService.shareInstance.like(url: url, params: params, completion: { [weak self] (result) in
//            guard let `self` = self else { return }
//
//            switch result {
//            case .networkSuccess(_):
//                sender.isSelected = true
//                sender.isFollow = "팔로잉"
//
//                break
//            case .accessDenied :
//                self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
//                    if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
//                        loginVC.entryPoint = 1
//                        self.present(loginVC, animated: true, completion: nil)
//                    }
//                })
//            case .networkFail :
//                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
//            default :
//                break
//            }
//
//        })
//    }
//
//    //좋아요 취소
//    func dislikeAction(url : String, sender : followBtn){
//        CommunityDislikeService.shareInstance.dislikeCommunity(url: url, completion: {  [weak self] (result) in
//            guard let `self` = self else { return }
//
//            switch result {
//            case .networkSuccess(_):
//                sender.isSelected = false
//                sender.isFollow = "팔로우"
//
//                break
//            case .accessDenied :
//                self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
//                    if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
//                        loginVC.entryPoint = 1
//                        self.present(loginVC, animated: true, completion: nil)
//                    }
//                })
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
