//
//  MainLikeTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 6..
//

import UIKit
import SnapKit

class MainLikeTVC: UITableViewController, APIService {
    
    var timeStamp = ""
    var legislatorLikeData : [Legislator] = [] {
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
        legislatorLikeInit()
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(startReloadTableView(_:)), for: .valueChanged)
    }
    
    @objc func vote(_ sender : LikeButton){
        getMyPoint(index : sender.index, row : sender.row)
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
            cell.configure(viewType : .like, row: indexPath.row, data: legislatorLikeData[indexPath.row])
            cell.voteBtn.addTarget(self, action: #selector(vote(_:)), for: .touchUpInside)
            return cell
        }
    }
    
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
        legislatorLikeInit(){sender.endRefreshing()}
    }
}
//통신
extension MainLikeTVC{
    //국회의원 리스트 불러오기 (호감)
    func legislatorLikeInit(completion : @escaping ()->() = {}){
        networkProvider.getAllLegislatorList(isLike: true) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .Success(let legislatorListInfo):
                //불러온 데이터의 시간과 현재 갖고있는 데이터의 시간이 같을 경우
                if legislatorListInfo.timeStamp == self.timeStamp {
                    self.simpleAlertwithHandler(title: "알림", message: self.timeStamp+"의 결과입니다. 투표 결과는 5분마다 갱신됩니다.", okHandler: { _ in
                        completion()
                    })
                } else {
                    self.timeStamp = legislatorListInfo.timeStamp
                    self.firstData = legislatorListInfo.data[0]
                    self.secondData = legislatorListInfo.data[1]
                    self.legislatorLikeData = legislatorListInfo.data
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
        networkProvider.vote(legiCode: legiCode, isLike: true) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .Success(_):
                //고치기 여기서 +해주기
                if (self.legislatorLikeData[row].voteCnt) != nil {
                    self.legislatorLikeData[row].voteCnt! += 1
                }
                self.voteDelegate?.myVoteDelegate(isLike: 1)
            case .Failure(let errorType) :
                self.showErrorAlert(errorType: errorType)
            }
        }
    } //voteOkAction
}
