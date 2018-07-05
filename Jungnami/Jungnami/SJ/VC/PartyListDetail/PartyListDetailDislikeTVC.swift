//
//  PartyListDetailDislikeTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 4..
//

import UIKit

class PartyListDetailDislikeTVC: UITableViewController {

    var selectedParty : PartyList?
    var sampleData : [SampleLegislator2] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //////////////////////뷰 보기 위한 샘플 데이터//////////////////////////
        let a = SampleLegislator2(profile: #imageLiteral(resourceName: "dabi"), name: "정다비", rank: 13, region: "서울 광진구 을", party : .green)
        let b = SampleLegislator2(profile: #imageLiteral(resourceName: "dabi"), name: "강병원", rank: 0, region: "서울 광진구 을", party: .yellow)
        sampleData.append(a)
        sampleData.append(b)
        /////////////////////////////////////////////////
        
    }
}


extension PartyListDetailDislikeTVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return sampleData.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: PartyListDetailFirstSectionTVCell.reuseIdentifier) as! PartyListDetailFirstSectionTVCell
            if let selectedParty_ = selectedParty {
                cell.configure(selectedParty: selectedParty_)
            }
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PartyListDetailTVcell.reuseIdentifier, for: indexPath) as! PartyListDetailTVcell
              cell.configure(index: indexPath.row, data: sampleData[indexPath.row])
            return cell
        }
    }
}
