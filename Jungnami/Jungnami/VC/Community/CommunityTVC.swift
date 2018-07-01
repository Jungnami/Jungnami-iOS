//
//  CommunityTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 1..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class CommunityTVC: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var badgeBackground: UIImageView!
    @IBOutlet weak var alertBadge: UILabel!
    @IBOutlet weak var searchTxtField: UITextField!
    @IBOutlet weak var containerView: UIView!
    
    @IBAction func myProfileBtn(_ sender: Any) {
        
    }
    
    @IBAction func alarmBtn(_ sender: Any) {

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //TODO
    //1. 나중에 유저가 로그인 되어있냐 안되어 있냐에 따라서 addChildView, removeChildView 함수 이용해서 보이는 뷰 바뀌게 하기
    //2. 만약 알람 없으면 뱃지 안보이게
    
    private lazy var firstViewController: NeedLoginVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "NeedLoginVC") as! NeedLoginVC
        return viewController
    }()
    
    private lazy var secondViewController: WriteVC = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "WriteVC") as! WriteVC
        return viewController
    }()

  

}

//tableView deleagete, datasource
extension CommunityTVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
}
