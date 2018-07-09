//
//  PartyListDetailLikeTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 4..
//

import UIKit



class PartyListDetailLikeTVC: UITableViewController,APIService {
    
    var selectedParty : PartyName?
    var selectedRegion : Region?
    var legislatorLikeData : [PartyLegistorLikeVOData] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.setContentOffset(.zero, animated: true)
        if let selectedParty_ = selectedParty {
            legislatorLikeInit(url: url("/legislatorlist/legislatorlist/1/\(selectedParty_.rawValue)"))
        }
        if let selectedRegion_ = selectedRegion {
            legislatorLikeInit(url: url("/legislatorlist/region/1/\(selectedRegion_.rawValue)"))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            cell.likeBtn.tag = indexPath.row
            cell.likeBtn.isUserInteractionEnabled = true
            cell.likeBtn.addTarget(self, action: #selector(vote(_:)), for: .touchUpInside)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let legislatorDetailVC = self.storyboard?.instantiateViewController(withIdentifier:LegislatorDetailVC.reuseIdentifier) as? LegislatorDetailVC {
            
            legislatorDetailVC.selectedLegislatorIdx = self.legislatorLikeData[indexPath.row].id
            
            self.navigationController?.pushViewController(legislatorDetailVC, animated: true)
        }
        
    }

}

//셀에 대한 행동 - 투표
extension PartyListDetailLikeTVC {
    @objc func vote(_ sender : UIButton){
        simpleAlertwithHandler(title: "투표하시겠습니까?", message: "나의 보유 투표권") { (_) in
            self.popupImgView(fileName: "area_like_popup")
        }
    }
}

//통신 - 정당별,지역별 호감 국회의원 목록 불러오기
extension PartyListDetailLikeTVC {
    //정당별,지역별 호감 국회의원 목록 불러오기
    func legislatorLikeInit(url : String){
        GetPartyLegislatorLikeService.shareInstance.getLegislatorLike(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let legislatorData):
                self.legislatorLikeData = legislatorData as! [PartyLegistorLikeVOData]
                self.tableView.reloadData()
                break
                
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결을 확인해주세요")
            default :
                break
            }
            
        })
        
    }
}
