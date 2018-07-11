//
//  FollowListVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 8..
//

import UIKit

class FollowListVC: UIViewController, UITableViewDelegate, UITableViewDataSource, APIService {
    
    @IBOutlet weak var followTableView: UITableView!
    @IBOutlet weak var followSearchField: UITextField!
    @IBOutlet weak var followSearchImg: UIImageView!
    var selectedUserId : String?
    @IBAction func dismissBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    var keyboardDismissGesture: UITapGestureRecognizer?
    //통신
    var followListData : [FollowListVOData]?
    /*
     let followingID, followingNickname, followingImgURL, isMyFollowing: String
     
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        followTableView.delegate = self
        followTableView.dataSource = self
        //네비게이션바 히든
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        //keyboardDown
        hideKeyboardWhenTappedAround()
        if let selectedUserId_ = selectedUserId {
            getFollwList(url: "/user/followinglist/\(selectedUserId_)")
        }
        
        //searchField
        //        if followSearchField.text != "" {
        //            followSearchImg.isHidden = true
        //        }else {
        //            followSearchImg.isHidden = false
        //        }
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
            return data.count
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
            cell.delegate = self
            return cell
        }
        
    }
}
extension FollowListVC : TapDelegate, UIGestureRecognizerDelegate {
    func myTableDelegate(index: Int) {
        print(index)
    }
}
extension FollowListVC {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChangeCoinVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//통신
extension FollowListVC {
    func getFollwList(url : String){
        
    }
}
//followList 불러오는 VO, Service만들기
extension FollowerListVC {
    
    func followerListInit(url : String){
        FollowListService.shareInstance.getFollowList(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let recommendData):
                //수정
                let recommendData = recommendData as! RecommendVOData//followListVC에서 받아올 것 var followData : [] 
//                self.contentData = recommendData.content.filter({
//                    $0.type == 0
//                })
//                self.alarmCount = recommendData.alarmcnt
//                self.contentCollectionView.reloadData()
                break
            case .nullValue :
                self.simpleAlert(title: "오류", message: "값 없음")
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
        
    }
}

