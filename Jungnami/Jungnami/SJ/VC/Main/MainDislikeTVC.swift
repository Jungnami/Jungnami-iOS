//
//  MainDislikeTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 6..
//

import UIKit

enum MainViewType {
    case like, dislike
}

class MainDislikeTVC: UITableViewController, APIService {
    
   var legislatorDislikeData : [Legislator] = []
    var firstData : Legislator?
    var secondData : Legislator?
    var voteDelegate : VoteDelegate?
    let networkProvider = NetworkManager.sharedInstance
  
    override func viewDidLoad() {
        super.viewDidLoad()
        //let itemCount = legislatorDislikeData.count
        //legislatorLikeInit(url : UrlPath.LegislatorList.getURL("0/\(itemCount)"))
        legislatorDislikeInit()
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(startReloadTableView(_:)), for: .valueChanged)
    }
    
    @objc func vote(_ sender : UIButton){
        getMyPoint(url : UrlPath.GetPointToVote.getURL(), index : sender.tag)
    }
    
    
    
}



//tableview deleagte, datasource
extension MainDislikeTVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return legislatorDislikeData.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainFirstSectionTVCell.reuseIdentifier) as! MainFirstSectionTVCell
            if let first = firstData, let second = secondData {
                cell.configure(first: first, second: second)
            }
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTVCell.reuseIdentifier, for: indexPath) as! MainTVCell
          
           cell.configure(viewType : .dislike, index: indexPath.row, data: legislatorDislikeData[indexPath.row])
            cell.voteBtn.tag = legislatorDislikeData[indexPath.row].idx
            cell.voteBtn.addTarget(self, action: #selector(vote(_:)), for: .touchUpInside)
            
            
            return cell
        }
    }
    
   /* override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItemIdx = legislatorDislikeData.count-1
        let itemCount = legislatorDislikeData.count
        if indexPath.row == lastItemIdx {
            legislatorLikeInit(url : UrlPath.LegislatorList.getURL("0/\(itemCount)"))
        }
    }*/
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = Storyboard.shared().mainStoryboard
        
        if let legislatorDetailVC = mainStoryboard.instantiateViewController(withIdentifier:LegislatorDetailVC.reuseIdentifier) as? LegislatorDetailVC {
            
          legislatorDetailVC.selectedLegislatorIdx = self.legislatorDislikeData[indexPath.row].idx
             legislatorDetailVC.selectedLegislatorName = self.legislatorDislikeData[indexPath.row].legiName
            self.navigationController?.pushViewController(legislatorDetailVC, animated: true)
        }
        
    }
}

//refreshControll
extension MainDislikeTVC{
    
    @objc func startReloadTableView(_ sender: UIRefreshControl){
        legislatorDislikeData = []
        legislatorDislikeInit()
//        let itemCount = legislatorDislikeData.count
//        legislatorLikeInit(url : UrlPath.LegislatorList.getURL("0/\(itemCount)"))
        self.tableView.reloadData()
        sender.endRefreshing()
    }
}
//통신

extension MainDislikeTVC {
    
    /*func legislatorLikeInit(url : String){
        GetLegislatorLikeService.shareInstance.getLegislatorLike(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let legislatorData):
                let legislatorData = legislatorData as! [LegislatorLikeVOData]
                if legislatorData.count > 0 {
                    self.legislatorDislikeData.append(contentsOf: legislatorData)
                    self.firstData = self.legislatorDislikeData[0]
                    self.secondData = self.legislatorDislikeData[1]
                    self.tableView.reloadData()
                }
                break
                
            case .networkFail :
                self.simpleAlert(title: "network", message: "check")
            default :
                break
            }
            
        })
        
    }*/
    func legislatorDislikeInit(){
        networkProvider.getAllLegislatorList(isLike: false) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .Success(let legislatorListInfo):
                self.firstData = legislatorListInfo.data[0]
                self.secondData = legislatorListInfo.data[1]
                self.legislatorDislikeData = legislatorListInfo.data
                self.tableView.reloadData()
            case .Failure(let errorType) :
                self.showErrorAlert(errorType: errorType)
            }
        }
    }
    
    //내 포인트 불러오기
    func getMyPoint(url : String, index : Int){
        GetPointService.shareInstance.getPoint(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let pointData):
                let myPoint = pointData as! Int
                self.simpleAlertwithHandler(title: "투표하시겠습니까?", message: "나의 보유 투표권: \(myPoint)개") { (_) in
                    //확인했을때 통신
                    let params : [String : Any] = [
                        "l_id" : index,
                        "islike" : 0
                    ]
                
                    self.voteOkAction(url: UrlPath.VoteLegislator.getURL(), params: params)
                }
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
    } //getMyPoint
    
   /* func temp(){
     let itemCount = legislatorDislikeData.count
     legislatorLikeInit(url : UrlPath.LegislatorList.getURL("0/\(itemCount)"))
    }
    */
    //내 포인트 보고 '확인'했을때 통신
    func voteOkAction(url : String, params : [String : Any]) {
        VoteService.shareInstance.vote(url: url, params : params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(_):
               self.voteDelegate?.myVoteDelegate(isLike: 0)
               //self.temp()
                break
            case .noPoint :
                self.simpleAlert(title: "오류", message: "포인트가 부족합니다")
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결을 확인해주세요")
            default :
                break
            }
            
        })
    } //voteOkAction
}
