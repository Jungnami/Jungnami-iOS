//
//  PartyListDetailLikeTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 4..
//

import UIKit



class PartyListDetailLikeTVC: UITableViewController,APIService {
    
    var selectedParty : PartyCode?
    var selectedRegion : CityCode?
    var legislatorLikeData : [CategorizedLegislator] = []
    var voteDelegate : VoteDelegate?
    var networkProvider = NetworkManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let itemCount = legislatorLikeData.count
        if let selectedParty_ = selectedParty {
            legislatorLikeInit(isParty: true, partyCode: selectedParty_, cityCode: nil)
        }
        if let selectedRegion_ = selectedRegion {
            legislatorLikeInit(isParty: false, partyCode: nil, cityCode: selectedRegion_)
        }
    }
}

//tableView dataSource, delegate
extension PartyListDetailLikeTVC {
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
    
    /*override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let section = indexPath.section
        if section == 1 {
            let lastItemIdx = legislatorLikeData.count-1
            let itemCount = legislatorLikeData.count
            if indexPath.row == lastItemIdx {
                if let selectedParty_ = selectedParty {
                    legislatorLikeInit(url:
                        UrlPath.PartyLegislatorList.getURL("\(selectedParty_.rawValue)/1/\(itemCount)"))
                }
                if let selectedRegion_ = selectedRegion {
                    legislatorLikeInit(url:  UrlPath.RegionLegislatorList.getURL("\(selectedRegion_.rawValue)/1/\(itemCount)"))
                }
            }
        }
    }*/
    
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
            
            cell.configure(index: indexPath.row, data: legislatorLikeData[indexPath.row])
            cell.likeBtn.tag = legislatorLikeData[indexPath.row].idx
            cell.likeBtn.isUserInteractionEnabled = true
            cell.likeBtn.addTarget(self, action: #selector(vote(_:)), for: .touchUpInside)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let legislatorDetailVC = self.storyboard?.instantiateViewController(withIdentifier:LegislatorDetailVC.reuseIdentifier) as? LegislatorDetailVC {
            legislatorDetailVC.selectedLegislatorIdx = self.legislatorLikeData[indexPath.row].idx
            legislatorDetailVC.selectedLegislatorName = self.legislatorLikeData[indexPath.row].legiName
            self.navigationController?.pushViewController(legislatorDetailVC, animated: true)
        }
    }
    
}

//셀에 대한 행동 - 투표
extension PartyListDetailLikeTVC {
    @objc func vote(_ sender : UIButton){
        getMyPoint(url : UrlPath.GetPointToVote.getURL(), index : sender.tag)
    }
}

//통신 - 정당별,지역별 호감 국회의원 목록 불러오기
extension PartyListDetailLikeTVC {
    //정당별,지역별 호감 국회의원 목록 불러오기
    func legislatorLikeInit(isParty: Bool, partyCode : PartyCode?, cityCode : CityCode?){
        if isParty {
            guard let partyCode = partyCode else {return}
            networkProvider.getPartyLegislatorList(isLike: true, party: partyCode) { [weak self] (result) in
                guard let `self` = self else { return }
                switch result {
                case .Success(let legislatorList):
                    self.legislatorLikeData = legislatorList
                    self.tableView.reloadData()
                case .Failure(let errorType) :
                    self.showErrorAlert(errorType: errorType)
                }
            }
        } else {
            guard let cityCode = cityCode else {return}
            networkProvider.getCityLegislatorList(isLike: true, city: cityCode) { [weak self] (result) in
                guard let `self` = self else { return }
                switch result {
                case .Success(let legislatorList):
                    self.legislatorLikeData = legislatorList
                    self.tableView.reloadData()
                case .Failure(let errorType) :
                    self.showErrorAlert(errorType: errorType)
                }
            }
        }
    }
    /*func legislatorLikeInit(url : String){
        GetPartyLegislatorLikeService.shareInstance.getLegislatorLike(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let legislatorData):
                let legislatorData = legislatorData as! [PartyLegistorLikeVOData]
                if legislatorData.count > 0 {
                    self.legislatorLikeData.append(contentsOf: legislatorData)
                    self.tableView.reloadData()
                }
                break
                
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결을 확인해주세요")
            default :
                break
            }
            
        })
    }*/
    
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
                        "islike" : 1
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
                self.voteDelegate?.myVoteDelegate(isLike: 1)
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
