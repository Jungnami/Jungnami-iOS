//
//  Extensions.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 1..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit
extension UIBarButtonItem {
    class func itemWith(colorfulImage: UIImage?, target: AnyObject, action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(colorfulImage, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 48).isActive = true
        button.heightAnchor.constraint(equalToConstant: 48).isActive = true
        button.addTarget(target, action: action, for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }
}

extension NSObject {
    static var reuseIdentifier:String {
        return String(describing:self)
    }
}

extension UIViewController {
    
     func addChildView(containerView : UIView, asChildViewController viewController: UIViewController) {
        
        addChildViewController(viewController)
        containerView.addSubview(viewController.view)
        
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParentViewController: self)
    }
    
     func removeChildView(containerView : UIView, asChildViewController viewController: UIViewController) {
        
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
}


