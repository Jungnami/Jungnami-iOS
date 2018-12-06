//
//  OtherUserPageVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 8. 9..
//


import UIKit
import LTScrollView

class OtherUserPageVC : UIViewController, APIService {
    
    let myScrapVC = MyPageScrapVC()
    let myFeedVC = MyPageFeedVC()
    var selectedUserId : String?
    
    var myBoardData : [MyPageVODataBoard]  = [] {
        didSet {
            myFeedVC.myBoardData = myBoardData
        }
    }
    var myScrapData : [MyPageVODataScrap]  = [] {
        didSet {
            myScrapVC.myScrapData = myScrapData
        }
    }
    
    private lazy var viewControllers: [UIViewController] = {
        return [myScrapVC, myFeedVC]
    }()
    
    private lazy var titles: [String] = {
        return ["스크랩", "내 피드"]
    }()
    
    //헤더 뷰 생성 후, 그 안에 프로퍼티들 설정
    private lazy var headerView : UIView = {
        let headerView = OtherUserHeaderView.instanceFromNib()
        headerView.dismissBtn.addTarget(self, action: #selector(self.dismiss(_:)), for: .touchUpInside)
        
        //
        headerView.otherUserFollowBtn.setImage(UIImage(named: "other-user-page_add_user"), for: .normal)
        headerView.otherUserFollowBtn.setImage(UIImage(named: "other-user-page_user_blue"), for: .selected)
        headerView.otherUserFollowBtn.addTarget(self, action: #selector(follow(_:)), for: .touchUpInside)
        
        //make label button
        let tapFollow = UITapGestureRecognizer(target: self, action: #selector(OtherUserPageVC.tapFollowLbl(_:)))
        headerView.profileFollowingNumLbl.isUserInteractionEnabled = true
        headerView.profileFollowingNumLbl.addGestureRecognizer(tapFollow)
        
        let tapFollower = UITapGestureRecognizer(target: self, action: #selector(OtherUserPageVC.tapFollowerLbl(_:)))
        headerView.profileFollowerNumLbl.isUserInteractionEnabled = true
        headerView.profileFollowerNumLbl.addGestureRecognizer(tapFollower)
        
        
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 232)
        return headerView
    }()
    
    private lazy var layout: LTLayout = {
        let layout = LTLayout()
        layout.titleViewBgColor = .white
        layout.titleColor = #colorLiteral(red: 0.8392156863, green: 0.8392156863, blue: 0.8392156863, alpha: 1)
        layout.titleSelectColor = ColorChip.shared().mainColor
        layout.sliderHeight = 41.0
        layout.bottomLineHeight = 0
        return layout
    }()
    
    
    private lazy var advancedManager: LTAdvancedManager = {
        let statusBarH = UIApplication.shared.statusBarFrame.size.height
        let Y: CGFloat = statusBarH
        let H: CGFloat = glt_iphoneX ? (view.bounds.height - Y - 34) : view.bounds.height - Y
        let advancedManager = LTAdvancedManager(frame: CGRect(x: 0, y: Y, width: view.bounds.width, height: H), viewControllers: viewControllers, titles: titles, currentViewController: self, layout: layout, headerViewHandle: {[weak self] in
            guard let strongSelf = self else { return UIView() }
            return headerView
        })
        
        return advancedManager
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedUserId_ = selectedUserId {
            getMyPage(url: UrlPath.Mypage.getURL(selectedUserId_))
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        // self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(advancedManager)
        advancedManagerConfig()
        
    }
    
    deinit {
        print("LTAdvancedManagerDemo < --> deinit")
    }
}

//LTAdvancedScrollViewDelegate
extension OtherUserPageVC {
    
    //MARK: 具体使用请参考以下
    private func advancedManagerConfig() {
        //MARK: 选中事件
        advancedManager.advancedDidSelectIndexHandle = {
            print("현재 인덱스는 -> \($0)")
        }
        
    }
}

//헤더 뷰에 대한것 설정
extension OtherUserPageVC {
    
    func setHeaderInfo(myPageData : MyPageVOData){
        
        guard let headerView_ = headerView as? OtherUserHeaderView else {return}
        
        if (self.gsno(myPageData.img) == "0") {
            headerView_.profileImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
            
        } else {
            if let url = URL(string: self.gsno(myPageData.img)){
                headerView_.profileImgView.kf.setImage(with: url)
            }
        }
        headerView_.profileImgView.makeImageRound()
        headerView_.profileuserNameLbl.text = myPageData.nickname
        headerView_.profileScrapNumLbl.text = "\(myPageData.scrapcnt)"
        headerView_.profileMyfeedNumLbl.text = "\(myPageData.boardcnt)"
        headerView_.profileFollowingNumLbl.text = "\(myPageData.followingcnt)"
        headerView_.profileFollowerNumLbl.text = "\(myPageData.followercnt)"

        if myPageData.isfollow == 0 {
            headerView_.otherUserFollowBtn.isSelected = false
            headerView_.otherUserFollowBtn.isFollow = "팔로우"
        }  else {
            headerView_.otherUserFollowBtn.isSelected = true
            headerView_.otherUserFollowBtn.isFollow = "팔로잉"
        }
        
    }//setHeaderInfo
    
}

//각종 버튼/레이블 클릭했을때 관한 이벤트들
extension OtherUserPageVC {
    @objc func dismiss(_ sender : UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func follow(_ sender : followBtn){
        //통신
        if sender.isFollow! == "팔로우" {
            likeAction(url: UrlPath.Follow.getURL(), userIdx : "\(selectedUserId!)", sender : sender )
        } else {
            dislikeAction(url:  UrlPath.Follow.getURL("\(selectedUserId!)"), sender : sender )
        }
        
    }
    
    //followLbl 터치했을 때 화면 올리기
    @objc func tapFollowLbl(_ sender: UITapGestureRecognizer) {
        if let followListVC = Storyboard.shared().subStoryboard.instantiateViewController(withIdentifier:FollowListVC.reuseIdentifier) as? FollowListVC {
            followListVC.selectedUserId = selectedUserId
            followListVC.entryPoint = 0
            followListVC.navTitle = "팔로잉"
            self.present(followListVC, animated: true, completion: nil)
        }
    }
    //followerLbl 터치했을 때 화면 올리기
    @objc func tapFollowerLbl(_ sender: UITapGestureRecognizer) {
        if let followListVC = Storyboard.shared().subStoryboard.instantiateViewController(withIdentifier:FollowListVC.reuseIdentifier) as? FollowListVC {
            followListVC.selectedUserId = selectedUserId
            followListVC.entryPoint = 1
            followListVC.navTitle = "팔로워"
            self.present(followListVC, animated: true, completion: nil)
        }
    }
    
}

//통신

extension OtherUserPageVC {
    func getMyPage(url : String) {
        MypageService.shareInstance.getUserPage(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let myPageData):
                
                let myPageData = myPageData as! MyPageVOData
                self.setHeaderInfo(myPageData: myPageData)
                
                
                self.myBoardData = myPageData.board
                self.myScrapData = myPageData.scrap
                
                break
            case .nullValue :
                self.simpleAlert(title: "오류", message: "값 없음")
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
    }
}


//통신
extension OtherUserPageVC {
    //하트 버튼 눌렀을 때
    func likeAction(url : String, userIdx : String, sender : followBtn){
        
        let params : [String : Any] = [
            "following_id" : userIdx
        ]
        CommunityLikeService.shareInstance.like(url: url, params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = true
                sender.isFollow = "팔로잉"
                
                break
            case .accessDenied :
                self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
                    if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
                        loginVC.entryPoint = 1
                        self.present(loginVC, animated: true, completion: nil)
                    }
                })
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
    }
    
    //좋아요 취소
    func dislikeAction(url : String, sender : followBtn){
        CommunityDislikeService.shareInstance.dislikeCommunity(url: url, completion: {  [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = false
                sender.isFollow = "팔로우"
                
                break
            case .accessDenied :
                self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
                    if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
                        loginVC.entryPoint = 1
                        self.present(loginVC, animated: true, completion: nil)
                    }
                })
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
    }
}
