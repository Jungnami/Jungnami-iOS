//
//  FollowerListVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 8..
//

import UIKit

class FollowerListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var keyboardDismissGesture: UITapGestureRecognizer?
    
    @IBOutlet weak var followerTableView: UITableView!
    
    
    @IBOutlet weak var searchField: UITextField!
    @IBAction func followerSearchField(_ sender: UITextField) {
        if searchField.text != "" {
            //?
        }else {
            simpleAlert(title: "알림", message: "검색어를 입력해주세요")
        }
    }
    
    
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        //취소버튼
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        followerTableView.delegate = self
        followerTableView.dataSource = self
        hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    var data = FollowListData.sharedInstance.followers
    //----------------tableView--------------------
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
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
            cell.delegate = self
            return cell
        }
    }
    
}
extension FollowerListVC: TapDelegate, UIGestureRecognizerDelegate {
    func myTableDelegate(index: Int) {
        print(index)
    }
    
}
extension FollowerListVC {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChangeCoinVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
