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
        boatAnimation = LOTAnimationView(name: "data")
        boatAnimation!.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        boatAnimation!.contentMode = .scaleAspectFit
        boatAnimation!.frame = view.bounds
        view.backgroundColor = ColorChip.shared().mainColor
        view.addSubview(boatAnimation!)
       
        boatAnimation!.loopAnimation = false
        boatAnimation!.play { (result) in
            self.finishLaunchScreenHandler!(result)
        }
    }
}
