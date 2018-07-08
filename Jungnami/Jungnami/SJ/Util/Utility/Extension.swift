//
//  Extension.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 2..
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
    
    func gsno(_ value : String?) -> String{
        return value ?? ""
    }
    
    func gino(_ value : Int?) -> Int {
        return value ?? 0
    }
    
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


extension UIImageView {
    func makeImageRound(){
        self.layer.cornerRadius = self.layer.frame.width/2
        self.layer.masksToBounds = true
    }
    
    func makeImgBorder(width : Int, color : UIColor){
        self.layer.borderWidth = CGFloat(width)
        self.layer.borderColor = color.cgColor
    }
}
extension UIViewController {
    func simpleAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func simpleAlertwithHandler(title: String, message: String, okHandler : ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default, handler: okHandler)
        let cancelAction = UIAlertAction(title: "취소",style: .cancel, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}


extension UIViewController {
    func customBarbuttonItem(title : String, red : Double, green : Double, blue : Double, fontSize : Int, selector : Selector?)->UIBarButtonItem{
        let customBarbuttonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: selector)
        let fontSize = UIFont.systemFont(ofSize: CGFloat(fontSize))
        customBarbuttonItem.setTitleTextAttributes([
            NSAttributedStringKey(rawValue: NSAttributedStringKey.font.rawValue): fontSize,
            NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue) : UIColor(red: CGFloat(red/255.0), green: CGFloat(green/255.0), blue: CGFloat(blue/255.0), alpha: CGFloat(1.0) )
            ], for: UIControlState.normal)
        return customBarbuttonItem
    }
    
        
        func setImgView(viewName:UIImageView,fileName:String) -> UIImageView {
            let theImageView = viewName
            theImageView.image = UIImage(named: fileName)
            theImageView.translatesAutoresizingMaskIntoConstraints = false //You need to call this property so the image is added to your view
            return theImageView
        }
        
        func setImageViewConstraints(_ imageView:UIImageView) {
            imageView.widthAnchor.constraint(equalToConstant: 180).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            imageView.contentMode = .scaleAspectFit
    }
}


extension UIView {
    
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func makeRounded(){
        self.layer.cornerRadius = self.layer.frame.height/2
        self.layer.masksToBounds = true
    }
    
}


extension UIViewController {
    func popupImgView(fileName : String){
        DispatchQueue.main.asyncAfter(deadline: .now()){
            var myPopupImgView = UIImageView()
            myPopupImgView = self.setImgView(viewName: myPopupImgView, fileName: fileName)
            self.view.addSubview(myPopupImgView)
            self.setImageViewConstraints(myPopupImgView)
            myPopupImgView.isHidden = false
            myPopupImgView.expand()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                myPopupImgView.isHidden = true
            }
        }
    }
}
extension UIView {
    //크기 키우는 효과
    func expand() {
        self.transform = self.transform.scaledBy(x: 0.25, y: 0.25)
        
        UIView.animate(withDuration: 0.1,
                       delay: 0.0,
                       usingSpringWithDamping: 1.5,
                       initialSpringVelocity: 0.1,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: ({
                        self.transform = self.transform.scaledBy(x: 4.0, y: 4.0)
                       }),
                       completion: nil)
    }
}

//컨스트레인
extension UIView {
    
    func removeConstraints() {
        removeConstraints(constraints)
    }
    
    func deactivateAllConstraints() {
        NSLayoutConstraint.deactivate(getAllConstraints())
    }
    
    func getAllSubviews() -> [UIView] {
        return UIView.getAllSubviews(view: self)
    }
    
    func getAllConstraints() -> [NSLayoutConstraint] {
        
        var subviewsConstraints = getAllSubviews().flatMap { (view) -> [NSLayoutConstraint] in
            return view.constraints
        }
        
        if let superview = self.superview {
            subviewsConstraints += superview.constraints.flatMap{ (constraint) -> NSLayoutConstraint? in
                if let view = constraint.firstItem as? UIView {
                    if view == self {
                        return constraint
                    }
                }
                return nil
            }
        }
        
        return subviewsConstraints + constraints
    }
    
    class func getAllSubviews(view: UIView) -> [UIView] {
        return view.subviews.flatMap { subView -> [UIView] in
            return [subView] + getAllSubviews(view: subView)
        }
    }
}


