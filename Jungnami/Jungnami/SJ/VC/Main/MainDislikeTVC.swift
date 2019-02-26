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
    
    var timeStamp = ""
    var legislatorDislikeData : [Legislator] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var firstData : Legislator?
    var secondData : Legislator?
    var voteDelegate : VoteDelegate?
    let networkProvider = NetworkManager.sharedInstance
  
    override func viewDidLoad() {
        super.viewDidLoad()
        legislatorDislikeInit()
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(startReloadTableView(_:)), for: .valueChanged)
    }
    
    @objc func vote(_ sender : LikeButton){
        getMyPoint(index : sender.index, row : sender.row)
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
          
           cell.configure(viewType : .dislike, row: indexPath.row, data: legislatorDislikeData[indexPath.row])
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
        //legislatorDislikeData = []
//        let itemCount = legislatorDislikeData.count
//        legislatorLikeInit(url : UrlPath.LegislatorList.getURL("0/\(itemCount)"))
        //self.tableView.reloadData()
          legislatorDislikeInit(){sender.endRefreshing()}
    }
}
//통신

extension MainDislikeTVC {
    func legislatorDislikeInit(completion : @escaping ()->() = {}){
        networkProvider.getAllLegislatorList(isLike: false) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .Success(let legislatorListInfo):
                if legislatorListInfo.timeStamp == self.timeStamp {
                    self.simpleAlertwithHandler(title: "알림", message: self.timeStamp+"의 결과입니다.\n투표 결과는 5분마다 갱신됩니다.", okHandler: { _ in
                        completion()
                    })
                } else {
                    self.timeStamp = legislatorListInfo.timeStamp
                    self.firstData = legislatorListInfo.data[0]
                    self.secondData = legislatorListInfo.data[1]
                    self.legislatorDislikeData = legislatorListInfo.data
                    completion()
                }
            case .Failure(let errorType) :
                self.showErrorAlert(errorType: errorType)
            }
            
        }
    }
    //내 포인트 불러오기
    func getMyPoint(index : Int, row : Int){
        networkProvider.checkBallot { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .Success(let voteCount):
                self.simpleAlertwithHandler(title: "투표하시겠습니까?", message: "나의 보유 투표권: \(voteCount)개") { (_) in
                    self.voteOkAction(legiCode: index, row : row)
                }
            case .Failure(let errorType) :
                self.showErrorAlert(errorType: errorType)
            }
        }
    } //getMyPoint
    
    
    //내 포인트 보고 '확인'했을때 통신
    func voteOkAction(legiCode : Int, row : Int) {
        networkProvider.vote(legiCode: legiCode, isLike: false) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .Success(_):
                if (self.legislatorDislikeData[row].voteCnt) != nil {
                    self.legislatorDislikeData[row].voteCnt! += 1
                }
                self.voteDelegate?.myVoteDelegate(isLike: 0)
            case .Failure(let errorType) :
                self.showErrorAlert(errorType: errorType)
            }
        }
    } //voteOkAction
}
