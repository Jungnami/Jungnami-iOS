//
//  MainLikeTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 6..
//

import UIKit
import SnapKit

class MainLikeTVC: UITableViewController, APIService {
    
    var legislatorLikeData : [LegislatorLikeVOData] = []
    var firstData : LegislatorLikeVOData?
    var secondData : LegislatorLikeVOData?
    var voteDelegate : VoteDelegate?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.setContentOffset(.zero, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let itemCount = legislatorLikeData.count
        legislatorLikeInit(url : UrlPath.LegislatorList.getURL("1/\(itemCount)"))
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(startReloadTableView(_:)), for: .valueChanged)
        
    }
    
    @objc func vote(_ sender : UIButton){
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
        let indexPath: IndexPath? = self.tableView.indexPathForRow(at: buttonPosition)
        
        let cell = self.tableView.cellForRow(at: indexPath!) as! MainTVCell
        print("like click envet happed!")
        getMyPoint(url : UrlPath.GetPointToVote.getURL(), index : sender.tag, cell : cell)
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
            
            cell.voteBtn.tag = legislatorLikeData[indexPath.row].lID
            cell.voteBtn.addTarget(self, action: #selector(vote(_:)), for: .touchUpInside)
            
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItemIdx = legislatorLikeData.count-1
        let itemCount = legislatorLikeData.count
        if indexPath.row == lastItemIdx {
            legislatorLikeInit(url : UrlPath.LegislatorList.getURL("1/\(itemCount)"))
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainStoryboard = Storyboard.shared().mainStoryboard
        
        if let legislatorDetailVC = mainStoryboard.instantiateViewController(withIdentifier:LegislatorDetailVC.reuseIdentifier) as? LegislatorDetailVC {
            
            
            legislatorDetailVC.selectedLegislatorIdx = self.legislatorLikeData[indexPath.row].lID
            legislatorDetailVC.selectedLegislatorName = self.legislatorLikeData[indexPath.row].lName
            
            self.navigationController?.pushViewController(legislatorDetailVC, animated: true)
        }
        
    }
    
    
    
}

//refreshContril
extension MainLikeTVC {
    
    @objc func startReloadTableView(_ sender: UIRefreshControl){
        legislatorLikeData = []
        let itemCount = legislatorLikeData.count
        legislatorLikeInit(url : UrlPath.LegislatorList.getURL("1/\(itemCount)"))
        self.tableView.reloadData()
        sender.endRefreshing()
    }
}
//통신
extension MainLikeTVC{
    
    //국회의원 리스트 불러오기 (호감)
    func legislatorLikeInit(url : String){
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
        
    }
    
    //내 포인트 불러오기
    func getMyPoint(url : String, index : Int, cell : MainTVCell){
        GetPointService.shareInstance.getPoint(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let pointData):
                let myPoint = pointData as! Int
                self.simpleAlertwithHandler(title: "투표하시겠습니까?", message: "나의 보유 투표권: \(myPoint)개") { (_) in
                    //확인했을때 통신
                    let params : [String : Any] = [
                        "l_id" : index,
                        "islike" : 1
                    ]
                    self.voteOkAction(url: UrlPath.VoteLegislator.getURL(), params: params, cell : cell)
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
    
    
    
    /*func temp(){
     let itemCount = legislatorLikeData.count
     legislatorLikeInit(url : UrlPath.LegislatorList.getURL("1/\(itemCount)"))
     }*/
    
    
    //내 포인트 보고 '확인'했을때 통신
    func voteOkAction(url : String, params : [String : Any], cell : MainTVCell) {
        VoteService.shareInstance.vote(url: url, params : params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(_):
                self.voteDelegate?.myVoteDelegate(isLike: 1)
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
