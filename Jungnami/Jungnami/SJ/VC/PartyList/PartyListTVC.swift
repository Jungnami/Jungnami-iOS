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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.setContentOffset(.zero, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        var selectedParty : PartyName
        switch index {
        case 0:
            selectedParty = .더불어민주당
        case 1:
            selectedParty = .자유한국당
        case 2:
            selectedParty = .바른미래당
        case 3:
            selectedParty = .정의당
        case 4:
            selectedParty = .민중당
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


