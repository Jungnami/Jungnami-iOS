//
//  MainLikeTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 6..
//

import UIKit
import SnapKit

class MainLikeTVC: UITableViewController {

    var sampleData : [SampleMain] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        /////////////////////Sample Data//////////////////////////
        let a = SampleMain(rank: 1, name: "김병관", profile : #imageLiteral(resourceName: "inni"), party: .orange, voteCount: 200000, rate : 1.0)
        let b = SampleMain(rank: 2, name: "정다비", profile : #imageLiteral(resourceName: "dabi"), party: .blue, voteCount: 10000, rate : 0.9)
        let c = SampleMain(rank: 2, name: "정다비", profile : #imageLiteral(resourceName: "dabi"), party: .blue, voteCount: 10000, rate : 0.8)
        let d = SampleMain(rank: 3, name: "정다비", profile : #imageLiteral(resourceName: "dabi"), party: .blue, voteCount: 10000, rate : 0.7)
        let e = SampleMain(rank: 4, name: "정다비", profile : #imageLiteral(resourceName: "dabi"), party: .blue, voteCount: 10000, rate : 0.4)
        let f = SampleMain(rank: 5, name: "정다비", profile : #imageLiteral(resourceName: "dabi"), party: .blue, voteCount: 10000, rate : 0.4)
        let g = SampleMain(rank: 5, name: "정다비", profile : #imageLiteral(resourceName: "dabi"), party: .blue, voteCount: 10000, rate : 0.4)
        let h = SampleMain(rank: 6, name: "정다비", profile : #imageLiteral(resourceName: "dabi"), party: .blue, voteCount: 10000, rate : 0.4)
        sampleData.append(contentsOf : [a,b,c,d,e,f,g,h])
        //////////////////////////////////////////////////////
       
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
            return sampleData.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainFirstSectionTVCell.reuseIdentifier) as! MainFirstSectionTVCell
            cell.configure(first: sampleData[0], second: sampleData[1])
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTVCell.reuseIdentifier, for: indexPath) as! MainTVCell
            
            cell.configure(index: indexPath.row, data: sampleData[indexPath.row])
            
            return cell
        }
    }
    
      override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("aa")
    }
    
    
    
}
