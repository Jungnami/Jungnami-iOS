//
//  PartyListTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 3..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

protocol PushVCProtocol : class {
    func pushAction(selectedParty: PartyList)
}

class PartyListTVC: UITableViewController {
    
    var keyboardDismissGesture: UITapGestureRecognizer?
    
    //노티를 날릴만한 뷰에서는 delegate 를 쓴다.
    var delegate: PushVCProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setKeyboardSetting()
        //        if #available(iOS 11.0, *) {
        //            tableView.contentInsetAdjustmentBehavior = .never
        //        }
        tableView.contentInset.bottom = self.tabBarController?.tabBar.frame.height ?? 49.0
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let index = indexPath.row
        var selectedParty : PartyList
        switch index {
        case 0:
            selectedParty = .blue
        case 1:
            selectedParty = .red
        case 2:
            selectedParty = .green
        case 3:
            selectedParty = .yellow
        case 4:
            selectedParty = .orange
        default:
            return
        }
        delegate?.pushAction(selectedParty: selectedParty)
    }
    
}


