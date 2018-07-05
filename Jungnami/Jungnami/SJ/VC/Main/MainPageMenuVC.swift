//
//  MainPageMenuVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 6..
//

import UIKit

class MainPageMenuVC: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    private lazy var mainLikeTVC: MainLikeTVC = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: MainLikeTVC.reuseIdentifier) as! MainLikeTVC
        
    
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var mainDislikeTVC: MainDislikeTVC = {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: MainDislikeTVC.reuseIdentifier) as! MainDislikeTVC
      
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    
    lazy var menuBar: MainMenuBar = {
        let mb = MainMenuBar()
        mb.homeController = self
        return mb
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMenuBar()
        setupView()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        // Do any additional setup after loading the view.
    }
    func scrollToMenuIndex(menuIndex: Int) {
        updateView(selected: menuIndex)
        
    }

   

}
//메뉴바랑 그 안 컨테이너뷰
extension MainPageMenuVC{
    
    
    static func viewController() -> PartyListDetailPageMenuVC {
        return UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: PartyListDetailPageMenuVC.reuseIdentifier) as! PartyListDetailPageMenuVC
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
            remove(asChildViewController: mainDislikeTVC)
            add(asChildViewController: mainLikeTVC)
        } else {
            remove(asChildViewController: mainLikeTVC)
            add(asChildViewController: mainDislikeTVC)
        }
    }
    
    //----------------------------------------------------------------
    
    func setupView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.topAnchor.constraint(equalTo: menuBar.bottomAnchor).isActive = true
        updateView(selected: 0)
    }
    
    private func setupMenuBar() {
        
        //메뉴바 삽입
        view.addSubview(menuBar)
        
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        menuBar.widthAnchor.constraint(equalToConstant: self.view.frame.width).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        menuBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        
    }
}
