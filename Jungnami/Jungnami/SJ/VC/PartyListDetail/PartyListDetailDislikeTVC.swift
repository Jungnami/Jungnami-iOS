//
//  PartyListDetailDislikeTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 4..
//

import UIKit

class PartyListDetailDislikeTVC: UITableViewController, APIService {
    
    var selectedParty : PartyName?
    var selectedRegion : Region?
    var legislatorDislikeData : [PartyLegistorLikeVOData] = []
    var voteDelegate : VoteDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.setContentOffset(.zero, animated: true)
        if let selectedParty_ = selectedParty {
            legislatorDislikeInit(url: UrlPath.PartyLegislatorDislikeList.getURL(selectedParty_.rawValue))
        }
        
        if let selectedRegion_ = selectedRegion {
            legislatorDislikeInit(url: UrlPath.RegionLegislatorDislikeList.getURL(selectedRegion_.rawValue))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}

//table view delegate, datasource
extension PartyListDetailDislikeTVC{
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
            
            let cell = tableView.dequeueReusableCell(withIdentifier: PartyListDetailFirstSectionTVCell.reuseIdentifier) as! PartyListDetailFirstSectionTVCell
            
            if let selectedParty_ = selectedParty {
                cell.configure(selectedParty: selectedParty_)
            }
            
            if let selectedRegion_ = selectedRegion {
                cell.configure2(selectedRegion: selectedRegion_)
            }
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PartyListDetailTVcell.reuseIdentifier, for: indexPath) as! PartyListDetailTVcell
            
            cell.configure(index: indexPath.row, data: legislatorDislikeData[indexPath.row])
            cell.likeBtn.tag = legislatorDislikeData[indexPath.row].id
            cell.likeBtn.isUserInteractionEnabled = true
            cell.likeBtn.addTarget(self, action: #selector(vote(_:)), for: .touchUpInside)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let legislatorDetailVC = self.storyboard?.instantiateViewController(withIdentifier:LegislatorDetailVC.reuseIdentifier) as? LegislatorDetailVC {
            
            legislatorDetailVC.selectedLegislatorIdx = self.legislatorDislikeData[indexPath.row].id
            legislatorDetailVC.selectedLegislatorName = self.legislatorDislikeData[indexPath.row].name
            self.navigationController?.pushViewController(legislatorDetailVC, animated: true)
        }
        
    }
}

//셀에 버튼에 대한 클릭 액션 - 투표
extension PartyListDetailDislikeTVC{
    @objc func vote(_ sender : UIButton){
            getMyPoint(url : UrlPath.VoteLegislator.getURL(), index : sender.tag)
        }
    
}

//통신 - 정당별, 지역별 비호감 의원 리스트 불러오기
extension PartyListDetailDislikeTVC{
    //정당별, 지역별 비호감 의원 리스트 불러오기
    func legislatorDislikeInit(url : String){
        GetPartyLegislatorLikeService.shareInstance.getLegislatorLike(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let legislatorData):
                self.legislatorDislikeData = legislatorData as! [PartyLegistorLikeVOData]
                self.tableView.reloadData()
                break
                
            case .networkFail :
                self.simpleAlert(title: "network", message: "check")
            default :
                break
            }
            
        })
        
    }
    
    //내 포인트 불러오기
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
    
    //내 포인트 보고 '확인'했을때 통신
    func voteOkAction(url : String, params : [String : Any]) {
        VoteService.shareInstance.vote(url: url, params : params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(_):
                 self.voteDelegate?.myVoteDelegate(isLike: 0)
                //self.popupImgView(fileName: "area_hate_popup")
                self.viewWillAppear(false)
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
