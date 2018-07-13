//
//  ContentVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 2..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit
import SnapKit

class ContentVC: UIViewController, AlarmProtocol, APIService{

    @IBOutlet weak var recommendBtn: UIButton!
    @IBOutlet weak var tmiBtn: UIButton!
    @IBOutlet weak var storyBtn: UIButton!
    
    @IBOutlet weak var contentContainerView: UIView!
    //메뉴 blueBar
    @IBOutlet weak var recommendBlueBar: UIImageView!
    @IBOutlet weak var tmiBlueBar: UIImageView!
    @IBOutlet weak var storyBlueBar: UIImageView!
    
    @IBOutlet weak var alarmCountLbl: UILabel!
    
    @IBOutlet weak var alarmBG: UIImageView!
    
    @IBOutlet weak var alarmBtn: UIButton!
    @IBOutlet weak var searchTxtField: UITextField!
    
    @IBOutlet weak var menuBarView: UIView!
    var keyboardDismissGesture: UITapGestureRecognizer?
    
    func getAlarm(alarmCount: Int) {
        if alarmCount == 0 {
            alarmCountLbl.isHidden = true
            alarmBG.isHidden = true
        } else {
            alarmCountLbl.isHidden = false
            alarmBG.isHidden = false
            if alarmCount > 99 {
                alarmCountLbl.text = "99+"
            } else {
                alarmCountLbl.text = "\(alarmCount)"
            }
        }
    }
    
  
    //mypageBtn
    @IBAction func myPageBtn(_ sender: Any) {
        let mypageVC = Storyboard.shared().mypageStoryboard.instantiateViewController(withIdentifier: MyPageVC.reuseIdentifier) as! MyPageVC
        let myId = UserDefaults.standard.string(forKey: "userIdx") ?? "-1"
        if (myId == "-1"){
            self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
                if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
                    loginVC.entryPoint = 1
                    self.present(loginVC, animated: true, completion: nil)
                }
            })
            
        } else {
            mypageVC.selectedUserId = myId
            self.present(mypageVC, animated: true, completion: nil)
        }
       
    }
    private lazy var recommendVC: ContentRecommendVC = {
        
        let storyboard = UIStoryboard(name: "Sub", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: ContentRecommendVC.reuseIdentifier) as! ContentRecommendVC
        
        viewController.alarmDelegate = self
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    private lazy var tmiVC: ContentTmiVC = {

        let storyboard = UIStoryboard(name: "Sub", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: ContentTmiVC.reuseIdentifier) as! ContentTmiVC
         viewController.alarmDelegate = self
        self.add(asChildViewController: viewController)

        return viewController
    }()
    private lazy var storyVC: ContentStoryVC = {
        
        let storyboard = UIStoryboard(name: "Sub", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: ContentStoryVC.reuseIdentifier) as! ContentStoryVC
         viewController.alarmDelegate = self
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    lazy var blackView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.4
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //blackView.isHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.navigationController?.navigationBar.shadowImage = UIImage()
         self.navigationController?.setNavigationBarHidden(true, animated: false)
        //        addNavBarImage()
        setKeyboardSetting()
        updateView(selected: 0)
        searchTxtField.delegate = self
        blackView.isHidden = true
        self.view.addSubview(blackView)
        blackView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(menuBarView.snp.bottom)
        }
         alarmBtn.addTarget(self, action:  #selector(toAlarmVC(_sender:)), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.searchTxtField.resignFirstResponder()
      
    }
    
    
    @IBAction func changView(_ sender: UIButton) {
        updateView(selected: sender.tag)
    }
    
//    func addNavBarImage() {
//
//        let navController = navigationController!
//
//        let image = UIImage(named: "content_search_field") //Your logo url here
//        let imageView = UIImageView(image: image)
//        imageView.frame = CGRect(x: 0, y: 0, width: 279, height: 31)
//        imageView.contentMode = .scaleAspectFit
//
//        navigationItem.titleView = imageView
//    }
   
}
extension ContentVC{
    
    static func viewController() -> ContentVC {
        return UIStoryboard.init(name: "Sub", bundle: nil).instantiateViewController(withIdentifier: ContentVC.reuseIdentifier) as! ContentVC
    }
    
    
    
    private func add(asChildViewController viewController: UIViewController) {
        
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        contentContainerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = contentContainerView.bounds
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
            //recommendBtn 누르면 나머지 tmi, 스토리 폰트컬러 기존색으로 바꾸고, tmi,story뷰 지워줌
            recommendBtn.setTitleColor(ColorChip.shared().mainColor, for: .normal)
            
            tmiBtn.setTitleColor(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1), for: .normal)
            storyBtn.setTitleColor(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1), for: .normal)
            
            recommendBlueBar.isHidden = false
            tmiBlueBar.isHidden = true
            storyBlueBar.isHidden = true
                
            remove(asChildViewController: tmiVC)
            remove(asChildViewController: storyVC)
            add(asChildViewController: recommendVC)
        }else if selected == 1 {
            tmiBtn.setTitleColor(ColorChip.shared().mainColor, for: .normal)
            
            recommendBtn.setTitleColor(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1), for: .normal)
            storyBtn.setTitleColor(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1), for: .normal)
            
            recommendBlueBar.isHidden = true
            tmiBlueBar.isHidden = false
            storyBlueBar.isHidden = true
            
            remove(asChildViewController: recommendVC)
            remove(asChildViewController: storyVC)
            add(asChildViewController: tmiVC)
        }else {
            storyBtn.setTitleColor(ColorChip.shared().mainColor, for: .normal)
            tmiBtn.setTitleColor(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1), for: .normal)
            recommendBtn.setTitleColor(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1), for: .normal)
            
            recommendBlueBar.isHidden = true
            tmiBlueBar.isHidden = true
            storyBlueBar.isHidden = false
            
            remove(asChildViewController: tmiVC)
            remove(asChildViewController: recommendVC)
            add(asChildViewController: storyVC)
        }
    }
}

extension ContentVC {
    @objc func toAlarmVC(_sender: UIButton){
        if let noticeVC = Storyboard.shared().subStoryboard.instantiateViewController(withIdentifier:NoticeVC.reuseIdentifier) as? NoticeVC {
            
            let myId = UserDefaults.standard.string(forKey: "userIdx") ?? "-1"
            if (myId == "-1"){
                self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
                    if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
                        loginVC.entryPoint = 1
                        self.present(loginVC, animated: true, completion: nil)
                    }
                })
                
            } else {
                self.present(noticeVC, animated : true)
            }
            
        }
    }
}


//txtField Delegate (엔터버튼 클릭시)
extension ContentVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            simpleAlert(title: "오류", message: "검색어 입력")
            return false
        }
        
        if let myString = textField.text {
            let emptySpacesCount = myString.components(separatedBy: " ").count-1
            
            if emptySpacesCount == myString.count {
                simpleAlert(title: "오류", message: "검색어 입력")
                return false
            }
        }
        
        if let searchString_ = textField.text {
            //여기서 searchContent(searchString : String, url : String) 부르면 됨
            searchContent(searchString : searchString_, url : url("/search/contents/\(searchString_)"))
        
        }
        
        
        return true
    }
}



//키보드 대응
extension ContentVC{
    func setKeyboardSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        blackView.isHidden = false
        adjustKeyboardDismissGesture(isKeyboardVisible: true)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        blackView.isHidden = true
        searchTxtField.text = ""
        // setDefaultNav()
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
        
    }
    
    //화면 바깥 터치했을때 키보드 없어지는 코드
    func adjustKeyboardDismissGesture(isKeyboardVisible: Bool) {
        if isKeyboardVisible {
            if keyboardDismissGesture == nil {
                keyboardDismissGesture = UITapGestureRecognizer(target: self, action: #selector(tapBackground))
                view.addGestureRecognizer(keyboardDismissGesture!)
            }
        } else {
            if keyboardDismissGesture != nil {
                view.removeGestureRecognizer(keyboardDismissGesture!)
                keyboardDismissGesture = nil
            }
        }
    }
    
    @objc func tapBackground() {
        
        self.view.endEditing(true)
    }
    
    
}

extension ContentVC {
    //콘텐츠 검색
    func searchContent(searchString : String, url : String){
        ContentSearchService.shareInstance.searchContent(url: url) { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let contentData):
                let contentSearchData = contentData as! [ContentSearchVOData]
                
                self.toSearchResultPage(searchString: searchString, contentSearchData: contentSearchData)
                break
            case .nullValue :
                self.simpleAlert(title: "오류", message: "검색 결과가 없습니다")
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
        }
    }
    
    func toSearchResultPage(searchString : String, contentSearchData : [ContentSearchVOData]){
        print("다음뷰")
        //다음뷰로 넘기기
        
        let subStoryboard = Storyboard.shared().subStoryboard
        if let contentSearchResultVC = subStoryboard.instantiateViewController(withIdentifier:ContentSearchResultVC.reuseIdentifier) as? ContentSearchResultVC {
          
            contentSearchResultVC.contendSearchData = contentSearchData
            contentSearchResultVC.searchString = searchString
        
            self.navigationController?.pushViewController(contentSearchResultVC, animated: true)
        }
    }
    
    
}
