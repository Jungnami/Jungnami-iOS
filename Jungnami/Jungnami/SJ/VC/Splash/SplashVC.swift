//
//  SplashVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 12. 11..
//

import UIKit
import Lottie

class SplashVC: UIViewController {
    
    private var downloadTask: URLSessionDownloadTask?
    private var boatAnimation: LOTAnimationView?
    var positionInterpolator: LOTPointInterpolatorCallback?
    var finishLaunchScreenHandler : ((Bool)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        boatAnimation = LOTAnimationView(name: "fabulous_onboarding_animation")
        boatAnimation!.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        boatAnimation!.contentMode = .scaleAspectFill
        boatAnimation!.frame = view.bounds
        view.backgroundColor = #colorLiteral(red: 0, green: 0.6549019608, blue: 0.7490196078, alpha: 1)
        view.addSubview(boatAnimation!)
       
        boatAnimation!.loopAnimation = false
        boatAnimation!.play { (result) in
            self.finishLaunchScreenHandler!(result)
        }
    }
}
