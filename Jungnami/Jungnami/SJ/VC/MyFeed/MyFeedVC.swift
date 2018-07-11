//
//  MyFeedVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 6..
//

import UIKit

class MyFeedVC: UIViewController, APIService {

    @IBOutlet weak var myFeedTableView: UITableView!
    var myBoardData : [MyPageVODataBoard]  = [] {
        didSet {
            if let myFeedTableView_ =  myFeedTableView{
                myFeedTableView_.reloadData()
            }
          
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myFeedTableView.delegate = self
        myFeedTableView.dataSource = self
       
    }


}


extension MyFeedVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myBoardData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if myBoardData[indexPath.row].source.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyFeedCell.reuseIdentifier, for: indexPath) as! MyFeedCell
          
          
            cell.commentBtn.addTarget(self, action: #selector(comment(_:)), for: .touchUpInside)
            cell.likeBtn.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
            cell.configure(data: myBoardData[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyFeedShareCell.reuseIdentifier, for: indexPath) as! MyFeedShareCell
         
            cell.commentBtn.addTarget(self, action: #selector(comment(_:)), for: .touchUpInside)
            cell.likeBtn.addTarget(self, action: #selector(sharedLike(_:)), for: .touchUpInside)
             cell.configure(data: myBoardData[indexPath.row])
            return cell
        }
        
    }
    
    
}

//셀들에 관한 것
extension MyFeedVC {
    
    @objc func comment(_ sender : myCommentBtn){
        let communityStoartyboard = Storyboard.shared().communityStoryboard
        
        if let commentVC = communityStoartyboard.instantiateViewController(withIdentifier:BoardDetailViewController.reuseIdentifier) as? BoardDetailViewController {
            
            commentVC.selectedBoard = sender.tag
            commentVC.heartCount = sender.likeCnt
            commentVC.commentCount = sender.commentCnt
            
            self.present(commentVC, animated: true)
        }
        
    }
    
    @objc func like(_ sender : myHeartBtn){
        //통신
        let buttonPosition = sender.convert(CGPoint.zero, to: self.myFeedTableView)
         let indexPath: IndexPath? = self.myFeedTableView.indexPathForRow(at: buttonPosition)
       
        let cell = self.myFeedTableView.cellForRow(at: indexPath!) as! MyFeedCell
        
        if sender.isLike! == 0 {
            likeAction(url: url("/board/likeboard"), boardIdx : sender.boardIdx!, isLike : sender.isLike!, cell : cell, sender : sender, likeCnt: sender.likeCnt )
        } else {
            dislikeAction(url: url("/delete/boardlike/\(sender.boardIdx!)"), cell : cell, sender : sender, likeCnt: sender.likeCnt )
        }
        
    }
    
    
    @objc func sharedLike(_ sender : myHeartBtn){
        //통신
        let buttonPosition = sender.convert(CGPoint.zero, to: self.myFeedTableView)
        let indexPath: IndexPath? = self.myFeedTableView.indexPathForRow(at: buttonPosition)
        
        let cell = self.myFeedTableView.cellForRow(at: indexPath!) as! MyFeedShareCell
        
        if sender.isLike! == 0 {
            sharedLikeAction(url: url("/board/likeboard"), boardIdx : sender.boardIdx!, isLike : sender.isLike!, cell : cell, sender : sender, likeCnt: sender.likeCnt )
        } else {
            sharedDislikeAction(url: url("/delete/boardlike/\(sender.boardIdx!)"), cell : cell, sender : sender, likeCnt: sender.likeCnt )
        }
        
    }
}


//통신
extension MyFeedVC {
    
    
    //하트 버튼 눌렀을 때
    func likeAction(url : String, boardIdx : Int, isLike : Int, cell : MyFeedCell, sender : myHeartBtn, likeCnt : Int){
        let params : [String : Any] = [
            "board_id" : boardIdx
        ]
        CommunityLikeService.shareInstance.like(url: url, params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = true
                sender.isLike = 1
                var changed : Int = 0
                //Now change the text and background colour
                if cell.likeCntLbl.text == "\(likeCnt)" {
                    changed = likeCnt+1
                } else {
                    changed = likeCnt
                }
                cell.likeCntLbl.text = "\(changed)"

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
    func dislikeAction(url : String, cell : MyFeedCell, sender : myHeartBtn, likeCnt : Int){
        CommunityDislikeService.shareInstance.dislikeCommunity(url: url, completion: {  [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = false
                sender.isLike = 0
                var changed : Int = 0
                
                //Now change the text and background colour
                if cell.likeCntLbl.text == "\(likeCnt)" {
                    changed = likeCnt-1
                } else {
                    changed = likeCnt
                }
                cell.likeCntLbl.text = "\(changed)"
                
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
    
    //하트 버튼 눌렀을 때
    func sharedLikeAction(url : String, boardIdx : Int, isLike : Int, cell : MyFeedShareCell, sender : myHeartBtn, likeCnt : Int){
        let params : [String : Any] = [
            "board_id" : boardIdx
        ]
        CommunityLikeService.shareInstance.like(url: url, params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = true
                sender.isLike = 1
                var changed : Int = 0
                //Now change the text and background colour
                if cell.likeCntLbl.text == "\(likeCnt)" {
                    changed = likeCnt+1
                } else {
                    changed = likeCnt
                }
                cell.likeCntLbl.text = "\(changed)"
                
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
    func sharedDislikeAction(url : String, cell : MyFeedShareCell, sender : myHeartBtn, likeCnt : Int){
        CommunityDislikeService.shareInstance.dislikeCommunity(url: url, completion: {  [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = false
                sender.isLike = 0
                var changed : Int = 0
                
                //Now change the text and background colour
                if cell.likeCntLbl.text == "\(likeCnt)" {
                    changed = likeCnt-1
                } else {
                    changed = likeCnt
                }
                cell.likeCntLbl.text = "\(changed)"
                
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

