//
//  LTAdvancedTestOneVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 8. 6..
//

import UIKit
import LTScrollView
import SnapKit

class MyPageFeedVC: UIViewController, LTTableViewProtocal, APIService {

    var myBoardData : [MyPageVODataBoard]  = [] {
        didSet {
             self.tableView.reloadData()
        }
    }
    
    private lazy var tableView: UITableView = {
        let H: CGFloat = glt_iphoneX ? (view.bounds.height - 64 - 24 - 34) : view.bounds.height - 20
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width: view.bounds.width, height: H), self, self, nil)
        tableView.tableFooterView = UIView(frame : .zero)
        return tableView
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        let mypageFeedTVCell = UINib.init(nibName: "MypageFeedTVCell", bundle: nil)
        self.tableView.register(mypageFeedTVCell, forCellReuseIdentifier: MypageFeedTVCell.reuseIdentifier)
        
         let mypageFeedScrapTVCell = UINib.init(nibName: "MypageFeedScrapTVCell", bundle: nil)
         self.tableView.register(mypageFeedScrapTVCell, forCellReuseIdentifier: MypageFeedScrapTVCell.reuseIdentifier)
        
        let mypageNoImageFeedTVcell = UINib.init(nibName: "MypageNoImageFeedTVcell", bundle: nil)
        self.tableView.register(mypageNoImageFeedTVcell, forCellReuseIdentifier: MypageNoImageFeedTVcell.reuseIdentifier)
        
        let mypageNoImageFeedScrapTVCell = UINib.init(nibName: "MypageNoImageFeedScrapTVCell", bundle: nil)
        self.tableView.register(mypageNoImageFeedScrapTVCell, forCellReuseIdentifier: MypageNoImageFeedScrapTVCell.reuseIdentifier)

        view.addSubview(tableView)
        glt_scrollView = tableView
       
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
}

extension MyPageFeedVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myBoardData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = myBoardData[indexPath.row]
        if data.source.count == 0 {
            //내 글
            if (gsno(data.bImg) == "0") {
                //이미지 없음
                let cell = tableView.dequeueReusableCell(withIdentifier: MypageNoImageFeedTVcell.reuseIdentifier, for: indexPath) as! MypageNoImageFeedTVcell
                
                cell.commentBtn.addTarget(self, action: #selector(comment(_:)), for: .touchUpInside)
                cell.likeBtn.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
                cell.likeBtn.tag = indexPath.row
                cell.configure(data: data)
                return cell
            } else {
               //이미지 있음
                let cell = tableView.dequeueReusableCell(withIdentifier: MypageFeedTVCell.reuseIdentifier, for: indexPath) as! MypageFeedTVCell
                cell.commentBtn.addTarget(self, action: #selector(comment(_:)), for: .touchUpInside)
                cell.likeBtn.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
                cell.likeBtn.tag = indexPath.row
                cell.configure(data: data)
                return cell
            }
        } else {
            //공유한 글
            if gsno(data.source[0].bImg) == "0" {
                //이미지 없음
                let cell = tableView.dequeueReusableCell(withIdentifier: MypageNoImageFeedScrapTVCell.reuseIdentifier, for: indexPath) as! MypageNoImageFeedScrapTVCell
                
                cell.commentBtn.addTarget(self, action: #selector(comment(_:)), for: .touchUpInside)
                cell.likeBtn.addTarget(self, action: #selector(sharedLike(_:)), for: .touchUpInside)
                cell.likeBtn.tag = indexPath.row
                cell.configure(data: data)
                return cell
            } else {
                //이미지 있음
                let cell = tableView.dequeueReusableCell(withIdentifier: MypageFeedScrapTVCell.reuseIdentifier, for: indexPath) as! MypageFeedScrapTVCell
                cell.commentBtn.addTarget(self, action: #selector(comment(_:)), for: .touchUpInside)
                cell.likeBtn.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
                cell.likeBtn.tag = indexPath.row
                cell.configure(data: data)
                return cell
            }
            
            
        }
        
    }
}



extension MyPageFeedVC {
    
    @objc func comment(_ sender : myCommentBtn){
        let communityStoartyboard = Storyboard.shared().communityStoryboard
        
        if let commentVC = communityStoartyboard.instantiateViewController(withIdentifier:CommentVC.reuseIdentifier) as? CommentVC {
            
            commentVC.selectedBoard = sender.tag
            commentVC.heartCount = sender.likeCnt
            commentVC.commentCount = sender.commentCnt
            
            self.present(commentVC, animated: true)
        }
        
    }
    
    @objc func like(_ sender : myHeartBtn){
    
        if sender.isLike! == 0 {
            likeAction(url: UrlPath.LikeBoard.getURL(), boardIdx : sender.boardIdx!, isLike : sender.isLike!, indexPathRow : sender.tag, sender : sender, likeCnt: sender.likeCnt )
        } else {
            dislikeAction(url: UrlPath.LikeBoard.getURL(sender.boardIdx!.description), indexPathRow : sender.tag, sender : sender, likeCnt: sender.likeCnt )
        }
        
    }
    
    
    @objc func sharedLike(_ sender : myHeartBtn){
        
        if sender.isLike! == 0 {
            sharedLikeAction(url: UrlPath.LikeBoard.getURL(), boardIdx : sender.boardIdx!, isLike : sender.isLike!, indexPathRow : sender.tag , sender : sender, likeCnt: sender.likeCnt )
        } else {
            sharedDislikeAction(url: UrlPath.LikeBoard.getURL(sender.boardIdx!.description), indexPathRow : sender.tag, sender : sender, likeCnt: sender.likeCnt )
        }
    }
}


//통신
extension MyPageFeedVC {
    
    
    //하트 버튼 눌렀을 때
    func likeAction(url : String, boardIdx : Int, isLike : Int, indexPathRow : Int, sender : myHeartBtn, likeCnt : Int){
        let params : [String : Any] = [
            "board_id" : boardIdx
        ]
        CommunityLikeService.shareInstance.like(url: url, params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = true
                sender.isLike = 1
                 self.myBoardData[indexPathRow].likeCnt += 1
                 self.myBoardData[indexPathRow].islike = 1
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
    func dislikeAction(url : String, indexPathRow : Int, sender : myHeartBtn, likeCnt : Int){
        CommunityDislikeService.shareInstance.dislikeCommunity(url: url, completion: {  [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = false
                sender.isLike = 0
                self.myBoardData[indexPathRow].likeCnt -= 1
                self.myBoardData[indexPathRow].islike = 0
                
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
    func sharedLikeAction(url : String, boardIdx : Int, isLike : Int, indexPathRow : Int, sender : myHeartBtn, likeCnt : Int){
        let params : [String : Any] = [
            "board_id" : boardIdx
        ]
        CommunityLikeService.shareInstance.like(url: url, params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = true
                sender.isLike = 1
                self.myBoardData[indexPathRow].likeCnt += 1
                self.myBoardData[indexPathRow].islike = 1
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
    func sharedDislikeAction(url : String, indexPathRow : Int, sender : myHeartBtn, likeCnt : Int){
        CommunityDislikeService.shareInstance.dislikeCommunity(url: url, completion: {  [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                sender.isSelected = false
                sender.isLike = 0
                self.myBoardData[indexPathRow].likeCnt -= 1
                self.myBoardData[indexPathRow].islike = 0
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

