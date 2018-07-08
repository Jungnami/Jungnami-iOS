//
//  FollowListVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 8..
//

import UIKit

class FollowListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var followTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        followTableView.delegate = self
        followTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 var data = FollowListData.sharedInstance.followers
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
                return 1
        }else {
            //data로 연결
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: FollowFixedCell.reuseIdentifier, for: indexPath) as! FollowFixedCell
            cell.followFixedLbl.text = "사람"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: FollowCell.reuseIdentifier, for: indexPath) as! FollowCell
            cell.configure(data: data[indexPath.row])
            return cell
        }
        
    }
}

