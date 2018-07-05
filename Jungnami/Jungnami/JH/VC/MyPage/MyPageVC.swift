//
//  MyPageVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 4..
//

import UIKit

class MyPageVC: UIViewController {

    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var profileuserNameLbl: UILabel!
    
    @IBOutlet weak var profileScrapNumLbl: UILabel!
    @IBOutlet weak var profileMyfeedNumLbl: UILabel!
    @IBOutlet weak var profileFollowingNumLbl: UILabel!
    @IBOutlet weak var profileFollowerNumLbl: UILabel!
    
    //알림, 설정, 버튼으로 연결해야함
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
