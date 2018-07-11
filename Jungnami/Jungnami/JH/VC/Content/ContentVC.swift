//
//  ContentVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 2..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class ContentVC: UIViewController {
    
    @IBOutlet weak var recommendBtn: UIButton!
    @IBOutlet weak var tmiBtn: UIButton!
    @IBOutlet weak var storyBtn: UIButton!
    
    @IBOutlet weak var contentContainerView: UIView!
    //메뉴 blueBar
    @IBOutlet weak var recommendBlueBar: UIImageView!
    @IBOutlet weak var tmiBlueBar: UIImageView!
    @IBOutlet weak var storyBlueBar: UIImageView!
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
        
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    private lazy var tmiVC: ContentTmiVC = {

        let storyboard = UIStoryboard(name: "Sub", bundle: Bundle.main)

        var viewController = storyboard.instantiateViewController(withIdentifier: ContentTmiVC.reuseIdentifier) as! ContentTmiVC

        self.add(asChildViewController: viewController)

        return viewController
    }()
    private lazy var storyVC: ContentStoryVC = {
        
        let storyboard = UIStoryboard(name: "Sub", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: ContentStoryVC.reuseIdentifier) as! ContentStoryVC
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
         self.navigationController?.setNavigationBarHidden(true, animated: false)
        //        addNavBarImage()
        updateView(selected: 0)
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

