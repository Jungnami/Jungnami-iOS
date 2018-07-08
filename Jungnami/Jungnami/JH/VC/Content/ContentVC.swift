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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
//        addNavBarImage()
       
    }
    private lazy var contentContainer: ContentContainerVC = {
        
        let storyboard = UIStoryboard(name: "Sub", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: ContentContainerVC.reuseIdentifier) as! ContentContainerVC
        
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
//
//    private lazy var myFeedVC: MyFeedVC = {
//
//        let storyboard = UIStoryboard(name: "Sub", bundle: Bundle.main)
//
//        var viewController = storyboard.instantiateViewController(withIdentifier: MyFeedVC.reuseIdentifier) as! MyFeedVC
//
//        self.add(asChildViewController: viewController)
//
//        return viewController
//    }()
    
    
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
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
            //투두 - 수진한테 물어보기 containerView에 연결된 VC가 하나의 형식이라 하나만 연결했는데 add,remove뷰를 어떻게 연결해야할지?!?!
//    private func updateView(selected : Int) {
//        if selected == 0 {
//            recommendBtn.setTitleColor(ColorChip.shared().mainColor, for: .normal)
//            
//            tmiBtn.setTitleColor(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1), for: .normal)
//            storyBtn.setTitleColor(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1), for: .normal)
//            
//            //remove(asChildViewController: )
////            add(asChildViewController: contentContainerView)
////            remove(asChildViewController: <#T##UIViewController#>)
//        }else if selected == 1 {
//            
//        }else {
//            feedBtn.setTitleColor(ColorChip.shared().mainColor, for: .normal)
//            
//            scapBtn.setTitleColor(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1), for: .normal)
//            
//            remove(asChildViewController: scrapCVC)
//            add(asChildViewController: myFeedVC)
//        }
//    }
}

