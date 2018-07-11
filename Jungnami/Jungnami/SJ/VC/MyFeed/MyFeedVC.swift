//
//  MyFeedVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 6..
//

import UIKit

class MyFeedVC: UIViewController {

    @IBOutlet weak var myFeedTableView: UITableView!
    var myBoardData : [MyPageVODataBoard]  = [] {
        didSet {
            if let myFeedTableView_ =  myFeedTableView{
                myFeedTableView_.reloadData()
                print("hihihihihihi")
            }
          
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        myFeedTableView.delegate = self
        myFeedTableView.dataSource = self
        // Do any additional setup after loading the view.
    }


}


extension MyFeedVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myBoardData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if myBoardData[indexPath.row].source.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyFeedCell.reuseIdentifier, for: indexPath) as! MyFeedCell
            cell.configure(data: myBoardData[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyFeedShareCell.reuseIdentifier, for: indexPath) as! MyFeedShareCell
             cell.configure(data: myBoardData[indexPath.row])
            return cell
        }
        
    }
    
    
}
