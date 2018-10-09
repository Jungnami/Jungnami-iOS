
//
//  NoticeVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 7..
//

import UIKit

class NoticeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, APIService {
    //-------------tapGesture-------------------------
    var keyboardDismissGesture: UITapGestureRecognizer?
    //-------------------------------------------------
    
    var alarmData : [AlarmVOData]?
    
    @IBOutlet weak var noticeTableView: UITableView!
    
    @IBAction func dismissBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        alarmInit(url: UrlPath.AlarmList.getURL())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //self.navigationController?.isNavigationBarHidden = true
        noticeTableView.tableFooterView = UIView(frame : .zero)
        noticeTableView.delegate = self
        noticeTableView.dataSource = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    //--------------tableView-------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let alarmData_ = alarmData {
            return alarmData_.count
        }
       return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoticeCell.reuseIdentifier, for: indexPath) as! NoticeCell
        if let alarmData_ = alarmData {
            cell.followBtn.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
             cell.configure(data: alarmData_[indexPath.row])
        }

        //tapGesture--------------
        cell.delegate = self
        //--------------------------
        return cell
    }
    
    @objc func like(_ sender : followBtn){
        //통신
        
        let buttonPosition = sender.convert(CGPoint.zero, to: self.noticeTableView)
        let indexPath: IndexPath? = self.noticeTableView.indexPathForRow(at: buttonPosition)
        let cell = self.noticeTableView.cellForRow(at: indexPath!) as! NoticeCell
        // 팔로우가 들어온다는 것은 아직 팔로잉 한 상태가 아니라는 것 => 그러니까 .isSelected = false
        //팔로잉이 들어온다는 것은 팔로잉을 하고 있다는것 => 그러니까 .isSelected = true
        if sender.isFollow! == "팔로우" {
            likeAction(url: UrlPath.Follow.getURL(), userIdx : sender.userIdx!,  cell : cell, sender : sender )
        } else {
            dislikeAction(url: UrlPath.User.getURL("\(sender.userIdx!)/unfollow"), cell : cell, sender : sender )
        }
        
    }
    
}
//-----------tapGesture---------------------------------------
extension NoticeVC : TapDelegate, UIGestureRecognizerDelegate {
    func myTableDelegate(index: Int) {
        print(index)
    }
}

extension NoticeVC {
    func alarmInit(url : String){
        AlarmService.shareInstance.getAlarm(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(let alarmData):
                self.alarmData = alarmData as? [AlarmVOData]
                self.noticeTableView.reloadData()
                break
                
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결을 확인해주세요")
            default :
                break
            }
            
        })
        
    }
}


extension NoticeVC {
    //하트 버튼 눌렀을 때
    func likeAction(url : String, userIdx : String,  cell : NoticeCell, sender : followBtn){
        
        let params : [String : Any] = [
            "following_id" : userIdx
        ]
        CommunityLikeService.shareInstance.like(url: url, params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = true
                sender.isFollow = "팔로잉"
                
                break
            case .accessDenied :
                self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
                    if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
                        loginVC.entryPoint = 1
                        self.present(loginVC, animated: true, completion: nil)
                    }
                })
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
    }
    
    //좋아요 취소
    func dislikeAction(url : String, cell : NoticeCell, sender : followBtn){
        CommunityDislikeService.shareInstance.dislikeCommunity(url: url, completion: {  [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = false
                sender.isFollow = "팔로우"
                
                
                break
            case .accessDenied :
                self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
                    if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
                        loginVC.entryPoint = 1
                        self.present(loginVC, animated: true, completion: nil)
                    }
                })
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
    }
}
