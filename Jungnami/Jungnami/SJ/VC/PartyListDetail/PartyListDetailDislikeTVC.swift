//
//  PartyListDetailDislikeTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 4..
//

import UIKit

class PartyListDetailDislikeTVC: UITableViewController {

    var selectedParty : PartyList?
    var selectedRegion : Region?
    var sampleData : [SampleLegislator] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //////////////////////뷰 보기 위한 샘플 데이터//////////////////////////
        sampleData = SampleLegislatorData.sharedInstance.legislators
        /////////////////////////////////////////////////
        print(selectedParty ?? 6)
        
        
    }
    
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
            
            if let selectedRegion_ = selectedRegion {
                cell.configure2(selectedRegion: selectedRegion_)
            }
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PartyListDetailTVcell.reuseIdentifier, for: indexPath) as! PartyListDetailTVcell

            
            cell.configure(index: indexPath.row, data: sampleData[indexPath.row])

            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let legislatorDetailVC = self.storyboard?.instantiateViewController(withIdentifier:LegislatorDetailVC.reuseIdentifier) as? LegislatorDetailVC {
            
            legislatorDetailVC.selectedLegislator = self.sampleData[indexPath.row]
            
            self.navigationController?.pushViewController(legislatorDetailVC, animated: true)
        }
        
    }
}
