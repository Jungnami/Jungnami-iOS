//
//  MainLikeTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 6..
//

import UIKit
import SnapKit

class MainLikeTVC: UITableViewController, APIService {
    
    var legislatorLikeData : [Datum] = []
    var firstData : Datum?
    var secondData : Datum?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        legislatorLikeInit(url : url("/ranking/list/1"))
       
        //self.tableView.setContentOffset(.zero, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(startReloadTableView(_:)), for: .valueChanged)
        
    }
    
    
    
    
    @objc func vote(_ sender : UIButton){
        getMyPoint(url : url("/legislator/voting"), index : sender.tag)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let mainStoryboard = Storyboard.shared().mainStoryboard
        
        //        var viewController = storyboard.instantiateViewController(withIdentifier: LegislatorDetailVC.reuseIdentifier) as! LegislatorDetailVC
        
        if let legislatorDetailVC = mainStoryboard.instantiateViewController(withIdentifier:LegislatorDetailVC.reuseIdentifier) as? LegislatorDetailVC {
            

            legislatorDetailVC.selectedLegislatorIdx = self.legislatorLikeData[indexPath.row].lID
            
            self.navigationController?.pushViewController(legislatorDetailVC, animated: true)
        }
        
    }
    
    
    
}

//refreshContril
extension MainLikeTVC {
    
    @objc func startReloadTableView(_ sender: UIRefreshControl){
        legislatorLikeInit(url : url("/ranking/list/1"))

        self.tableView.reloadData()
        sender.endRefreshing()
    }
}
//통신
extension MainLikeTVC{
    
    func legislatorLikeInit(url : String){
        GetLegislatorLikeService.shareInstance.getLegislatorLike(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let legislatorData):
                self.legislatorLikeData = legislatorData as! [Datum]
                self.firstData = self.legislatorLikeData[0]
                self.secondData = self.legislatorLikeData[1]
                self.tableView.reloadData()
                break
                
            case .networkFail :
                self.simpleAlert(title: "network", message: "check")
            default :
                break
            }
            
        })
        
    }
    
    func getMyPoint(url : String, index : Int){
        GetPointService.shareInstance.getPoint(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let pointData):
                let data = pointData as! PointVOData
                let myPoint = data.votingCnt
                self.simpleAlertwithHandler(title: "투표하시겠습니까?", message: "나의 보유 투표권: \(myPoint)개") { (_) in
                    //확인했을때 통신
                    let params : [String : Any] = [
                        "l_id" : index,
                        "islike" : 1
                    ]
                
                    self.voteOkAction(url: self.url("/legislator/voting"), params: params)
                }
                break
            case .accessDenied :
            self.simpleAlert(title: "오류", message: "로그인해주세요")
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
    } //getMyPoint
    
    
    func voteOkAction(url : String, params : [String : Any]) {
        VoteService.shareInstance.vote(url: url, params : params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(_):
                self.popupImgView(fileName: "area_like_popup")
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
