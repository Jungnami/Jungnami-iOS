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
    
    var sampleData : [SampleLegislator] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.setContentOffset(.zero, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(startReloadTableView(_:)), for: .valueChanged)
        
        /////////////////////Sample Data//////////////////////////
        
        sampleData = SampleLegislatorData.sharedInstance.legislators
        //////////////////////////////////////////////////////
        
    }
    
    @objc func vote(_ sender : UIButton){
        simpleAlertwithHandler(title: "투표하시겠습니까?", message: "나의 보유 투표권") { (_) in
            self.popupImgView(fileName: "ranking_hate")
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
        let mainStoryboard = Storyboard.shared().mainStoryboard
        
        if let legislatorDetailVC = mainStoryboard.instantiateViewController(withIdentifier:LegislatorDetailVC.reuseIdentifier) as? LegislatorDetailVC {
            
            legislatorDetailVC.selectedLegislator = self.sampleData[indexPath.row]
            
            self.navigationController?.pushViewController(legislatorDetailVC, animated: true)
        }
        
    }
}

//refreshControll
extension MainDislikeTVC{
    
    @objc func startReloadTableView(_ sender: UIRefreshControl){
        let aa = SampleLegislator(profile: #imageLiteral(resourceName: "dabi"), name: "sample Data", likeCount: 12, dislikeCount: 1, region: "서울 성북구 안암동", party: .blue, likeRank: 12, dislikeRank: 4, voteCount: 200000, rate: 1.8)
        sampleData.append(aa)
        
        self.tableView.reloadData()
        sender.endRefreshing()
    }
}
