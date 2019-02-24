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
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let index = indexPath.row
        var selectedParty : PartyCode
        switch index {
        case 0:
            selectedParty = .dubuleo
        case 1:
            selectedParty = .jahan
        case 2:
            selectedParty = .bami
        case 3:
            selectedParty = .jungeui
        case 4:
            selectedParty = .minjung
        case 5:
            selectedParty = .daehan
        case 6:
            selectedParty = .minpyung
        case 7:
            selectedParty = .none
        default:
            return
        }
        if let partyListDetailPageMenuVC = self.storyboard?.instantiateViewController(withIdentifier:PartyListDetailPageMenuVC.reuseIdentifier) as? PartyListDetailPageMenuVC {
            partyListDetailPageMenuVC.selectedParty = selectedParty
            
           partyListDetailPageMenuVC.navTitle = "정당"
            self.navigationController?.pushViewController(partyListDetailPageMenuVC, animated: true)
        }
        
       // delegate?.pushAction(selectedParty: selectedParty)
    }
    
}


