//
//  MainDislikeTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 6..
//

import UIKit

enum MainViewType {
    case like, dislike
}

class MainDislikeTVC: UITableViewController {

    var sampleData : [SampleMain] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(startReloadTableView(_:)), for: .valueChanged)
        
        /////////////////////Sample Data//////////////////////////
        let a = SampleMain(rank: 1, name: "김병관", profile : #imageLiteral(resourceName: "inni"), party: .orange, voteCount: 200000, rate : 1.0)
        let b = SampleMain(rank: 2, name: "정다비", profile : #imageLiteral(resourceName: "dabi"), party: .blue, voteCount: 10000, rate : 0.9)
        let c = SampleMain(rank: 3, name: "정다비", profile : #imageLiteral(resourceName: "dabi"), party: .blue, voteCount: 10000, rate : 0.8)
        let d = SampleMain(rank: 4, name: "정다비", profile : #imageLiteral(resourceName: "dabi"), party: .blue, voteCount: 10000, rate : 0.7)
        let e = SampleMain(rank: 4, name: "정다비", profile : #imageLiteral(resourceName: "dabi"), party: .blue, voteCount: 10000, rate : 0.4)
        let f = SampleMain(rank: 5, name: "정다비", profile : #imageLiteral(resourceName: "dabi"), party: .blue, voteCount: 10000, rate : 0.4)
        let g = SampleMain(rank: 5, name: "정다비", profile : #imageLiteral(resourceName: "dabi"), party: .blue, voteCount: 10000, rate : 0.4)
        let h = SampleMain(rank: 6, name: "정다비", profile : #imageLiteral(resourceName: "dabi"), party: .blue, voteCount: 10000, rate : 0.4)
        let i = SampleMain(rank: 7, name: "정다비", profile : #imageLiteral(resourceName: "dabi"), party: .blue, voteCount: 10000, rate : 0.2)
        let j = SampleMain(rank: 8, name: "정다비", profile : #imageLiteral(resourceName: "dabi"), party: .blue, voteCount: 10000, rate : 0.3)
        let k = SampleMain(rank: 9, name: "정다비", profile : #imageLiteral(resourceName: "dabi"), party: .blue, voteCount: 10000, rate : 0.7)
        sampleData.append(contentsOf : [a,b,c,d,e,f,g,h,i,j,k])
        //////////////////////////////////////////////////////
        
    }
    
    @objc func vote(_ sender : UIButton){
        simpleAlertwithHandler(title: "투표하시겠습니까?", message: "나의 보유 투표권") { (_) in
            print("vote!")
        }
    }

}


//tableview deleagte, datasource
extension MainDislikeTVC {
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
            
            cell.configure(viewType : .dislike, index: indexPath.row, data: sampleData[indexPath.row])
            cell.voteBtn.tag = indexPath.row
            cell.voteBtn.addTarget(self, action: #selector(vote(_:)), for: .touchUpInside)
            
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//refreshControll
extension MainDislikeTVC{
    
    @objc func startReloadTableView(_ sender: UIRefreshControl){
        let aa = SampleMain(rank: 1, name: "추가데이터", profile : #imageLiteral(resourceName: "inni"), party: .orange, voteCount: 200000, rate : 1.0)
        sampleData.append(aa)
      
        self.tableView.reloadData()
        sender.endRefreshing()
    }
}
