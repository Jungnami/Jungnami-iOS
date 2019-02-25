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
        legislatorDislikeInit()
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(startReloadTableView(_:)), for: .valueChanged)
    }
    
    @objc func vote(_ sender : UIButton){
        getMyPoint(index: sender.tag)
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
    func getMyPoint(index : Int){
        networkProvider.checkBallot { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .Success(let voteCount):
                self.simpleAlertwithHandler(title: "투표하시겠습니까?", message: "나의 보유 투표권: \(voteCount)개") { (_) in
                    self.voteOkAction(legiCode: index)
                }
            case .Failure(let errorType) :
                self.showErrorAlert(errorType: errorType)
            }
        }
    } //getMyPoint
    
    
    //내 포인트 보고 '확인'했을때 통신
    func voteOkAction(legiCode : Int) {
        networkProvider.vote(legiCode: legiCode, isLike: false) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .Success(_):
                self.voteDelegate?.myVoteDelegate(isLike: 0)
            case .Failure(let errorType) :
                self.showErrorAlert(errorType: errorType)
            }
        }
    } //voteOkAction
}
