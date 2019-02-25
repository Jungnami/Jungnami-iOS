//
//  MainLikeTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 6..
//

import UIKit
import SnapKit

class MainLikeTVC: UITableViewController, APIService {
    
    var legislatorLikeData : [Legislator] = []
    var firstData : Legislator?
    var secondData : Legislator?
    var voteDelegate : VoteDelegate?
    let networkProvider = NetworkManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //oldVersion
        //let itemCount = legislatorLikeData.count
        //legislatorLikeInit(url : UrlPath.LegislatorList.getURL("1/\(itemCount)"))
        legislatorLikeInit()
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(startReloadTableView(_:)), for: .valueChanged)
        
    }
    
    @objc func vote(_ sender : UIButton){
        getMyPoint(index : sender.tag)
    }
    
    
    
}

//tableview deleagte, datasource
extension MainLikeTVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return legislatorLikeData.count
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
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTVCell.reuseIdentifier) as! MainTVCell
            
            cell.configure(viewType : .like, index: indexPath.row, data: legislatorLikeData[indexPath.row])
            
            cell.voteBtn.tag = legislatorLikeData[indexPath.row].idx
            cell.voteBtn.addTarget(self, action: #selector(vote(_:)), for: .touchUpInside)
            
            
            return cell
        }
    }
    
    //oldVersion
   /* override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItemIdx = legislatorLikeData.count-1
        let itemCount = legislatorLikeData.count
        if indexPath.row == lastItemIdx {
            legislatorLikeInit(url : UrlPath.LegislatorList.getURL("1/\(itemCount)"))
        }
    }*/
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainStoryboard = Storyboard.shared().mainStoryboard
        
        if let legislatorDetailVC = mainStoryboard.instantiateViewController(withIdentifier:LegislatorDetailVC.reuseIdentifier) as? LegislatorDetailVC {
            
            
            legislatorDetailVC.selectedLegislatorIdx = self.legislatorLikeData[indexPath.row].idx
            legislatorDetailVC.selectedLegislatorName = self.legislatorLikeData[indexPath.row].legiName
            
            self.navigationController?.pushViewController(legislatorDetailVC, animated: true)
        }
        
    }
    
    
    
}

//refreshContril
extension MainLikeTVC {
    
    @objc func startReloadTableView(_ sender: UIRefreshControl){
        legislatorLikeData = []
        //oldVersion
        //let itemCount = legislatorLikeData.count
        //legislatorLikeInit(url : UrlPath.LegislatorList.getURL("1/\(itemCount)"))
        legislatorLikeInit()
        self.tableView.reloadData()
        sender.endRefreshing()
    }
}
//통신
extension MainLikeTVC{
    
    
    //oldVersion
    /*func legislatorLikeInit(url : String){
        GetLegislatorLikeService.shareInstance.getLegislatorLike(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let legislatorData):
                let legislatorData = legislatorData as! [LegislatorLikeVOData]
                if legislatorData.count > 0 {
                    self.legislatorLikeData.append(contentsOf: legislatorData)
                    self.firstData = self.legislatorLikeData[0]
                    self.secondData = self.legislatorLikeData[1]
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
    
    //국회의원 리스트 불러오기 (호감)
    func legislatorLikeInit(){
        networkProvider.getAllLegislatorList(isLike: true) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .Success(let legislatorListInfo):
                self.firstData = legislatorListInfo.data[0]
                self.secondData = legislatorListInfo.data[1]
                self.legislatorLikeData = legislatorListInfo.data
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
        networkProvider.vote(legiCode: legiCode, isLike: true) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .Success(_):
                self.voteDelegate?.myVoteDelegate(isLike: 1)
            case .Failure(let errorType) :
                self.showErrorAlert(errorType: errorType)
            }
        }
    } //voteOkAction
}
