//
//  SearchLegislatorResultTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 3..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class SearchLegislatorResultTVC: UITableViewController {

    var sampleData : [SampleLegislator] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //////////////////////뷰 보기 위한 샘플 데이터//////////////////////////
       let a = SampleLegislator(profile: #imageLiteral(resourceName: "community_mypage"), name: "김성태", likeCount: 12, dislikeCount: 45, region: "서울 강서구 을")
        let b = SampleLegislator(profile: #imageLiteral(resourceName: "community_mypage"), name: "김성태", likeCount: 12, dislikeCount: 45, region: "당대표, 서울 광진구 을")
        
        sampleData.append(a)
        sampleData.append(b)
        ////////////////////////////////////////////////////
        
    }

}

//tableview delegate, datasource
extension SearchLegislatorResultTVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sampleData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchLegislatorResultTVCell.reuseIdentifier) as! SearchLegislatorResultTVCell
        let rank = indexPath.row+1
        cell.configure(rank: rank, data: sampleData[indexPath.row])
        return cell
        
    }
}
