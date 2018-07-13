//
//  chargeVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 9..
//

import UIKit

class ChargeVC: UIViewController {

    
    @IBAction func changeView(_ sender: UIButton) {
        updateView(selected: sender.tag)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView(selected: 0)
    }
    @IBOutlet weak var chargeCoinBtn: UIButton!
    @IBOutlet weak var chargeVoteBtn: UIButton!
    
    @IBOutlet weak var chargeContainerView: UIView!
    @IBOutlet weak var chargeCoinBar: UIView!
    @IBOutlet weak var chargeVoteBar: UIView!
    
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    
    //--------------containerView-----------------------
    private lazy var myCoinVC: MyCoinVC = {
        
        let storyboard = UIStoryboard(name: "Sub", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: MyCoinVC.reuseIdentifier) as! MyCoinVC
        
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var changeCoinVC: ChangeCoinVC = {
        
        let storyboard = UIStoryboard(name: "Sub", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: ChangeCoinVC.reuseIdentifier) as! ChangeCoinVC
        
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
extension ChargeVC{
    
    static func viewController() -> ChargeVC {
        return UIStoryboard.init(name: "Sub", bundle: nil).instantiateViewController(withIdentifier: ChargeVC.reuseIdentifier) as! ChargeVC
    }
    
    
    
    private func add(asChildViewController viewController: UIViewController) {
        
        // Add Child View Controller
        addChildViewController(viewController)
        
        // Add Child View as Subview
        chargeContainerView.addSubview(viewController.view)
        
        // Configure Child View
        viewController.view.frame = chargeContainerView.bounds
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
            chargeCoinBtn.setTitleColor(ColorChip.shared().mainColor, for: .normal)
            
            chargeVoteBtn.setTitleColor(#colorLiteral(red: 0.8510189652, green: 0.85114187, blue: 0.8509921432, alpha: 1), for: .normal)
            chargeCoinBtn.setTitleColor(#colorLiteral(red: 0.2117647059, green: 0.7725490196, blue: 0.9450980392, alpha: 1), for: .normal)
            chargeCoinBar.isHidden = false
            chargeVoteBar.isHidden = true
            
            remove(asChildViewController: changeCoinVC)
            add(asChildViewController: myCoinVC)
        } else {
            chargeVoteBtn.setTitleColor(ColorChip.shared().mainColor, for: .normal)
            chargeCoinBtn.setTitleColor(#colorLiteral(red: 0.8510189652, green: 0.85114187, blue: 0.8509921432, alpha: 1), for: .normal)
            chargeVoteBtn.setTitleColor(#colorLiteral(red: 0.2117647059, green: 0.7725490196, blue: 0.9450980392, alpha: 1), for: .normal)
            
            chargeCoinBar.isHidden = true
            chargeVoteBar.isHidden = false
            
            remove(asChildViewController: myCoinVC)
            add(asChildViewController: changeCoinVC)
        }
    }
}


