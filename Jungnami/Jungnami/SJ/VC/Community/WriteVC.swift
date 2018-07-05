//
//  WriteVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 1..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class WriteVC: UIViewController {
    
    @IBOutlet weak var userImgView: UIImageView!
    
    @IBAction func toNextPage(_ sender: Any) {
        if let communityWriteVC = self.storyboard?.instantiateViewController(withIdentifier:CommunityWriteVC.reuseIdentifier) as? CommunityWriteVC {
            self.present(communityWriteVC, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userImgView.makeImageRound()
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
