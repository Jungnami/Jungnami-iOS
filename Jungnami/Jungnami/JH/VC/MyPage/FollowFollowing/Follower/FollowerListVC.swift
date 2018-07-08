//
//  FollowerListVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 8..
//

import UIKit

class FollowerListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var followerTableView: UITableView!
    
    @IBAction func dismissBtn(_ sender: Any) {
        //취소버튼
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        followerTableView.delegate = self
        followerTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    var data = FollowListData.sharedInstance.followers
    //----------------tableView--------------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            return data.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: FollowerFixedCell.reuseIdentifier, for: indexPath) as! FollowerFixedCell
        cell.fixedLbl.text = "사람"
            
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FollowerCell.reuseIdentifier, for: indexPath) as! FollowerCell
            cell.configure(data: data[indexPath.row])
            return cell
        }
    }
    
}
