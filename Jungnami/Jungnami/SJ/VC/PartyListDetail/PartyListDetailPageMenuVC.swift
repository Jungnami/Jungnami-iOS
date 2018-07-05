//
//  PartyListDetailPageMenuVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 4..
//

import UIKit
import PageMenu

class PartyListDetailPageMenuVC : UIViewController, CAPSPageMenuDelegate{
     var pageMenu: CAPSPageMenu?
     var selectedParty : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageMenu()
    }
}

extension PartyListDetailPageMenuVC {
    func setupPageMenu(){
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        var controllerArray : [UIViewController] = []
        
        let partyListDetailLikeTVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: PartyListDetailLikeTVC.reuseIdentifier) as! PartyListDetailLikeTVC
        
        partyListDetailLikeTVC.title = "호감"
        partyListDetailLikeTVC.selectedParty = selectedParty
        controllerArray.append(partyListDetailLikeTVC)
        
        let partyListDetailDislikeTVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: PartyListDetailDislikeTVC.reuseIdentifier) as! PartyListDetailDislikeTVC
        partyListDetailDislikeTVC.title = "비호감"
        partyListDetailDislikeTVC.selectedParty = selectedParty
        controllerArray.append(partyListDetailDislikeTVC)
        
        
        let parameters: [CAPSPageMenuOption] = [
            .menuItemSeparatorWidth(0),
            .scrollMenuBackgroundColor(.white),
            .viewBackgroundColor(#colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9843137255, alpha: 1)),
            .bottomMenuHairlineColor(#colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)),
            .selectionIndicatorColor(#colorLiteral(red: 0.2117647059, green: 0.7725490196, blue: 0.9450980392, alpha: 1)),
            .menuHeight(42.0),
            .selectedMenuItemLabelColor(#colorLiteral(red: 0.2117647059, green: 0.7725490196, blue: 0.9450980392, alpha: 1)),
            .unselectedMenuItemLabelColor(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)),
            .useMenuLikeSegmentedControl(true),
            .menuItemSeparatorRoundEdges(true),
            .selectionIndicatorHeight(3.0),
            .menuItemSeparatorPercentageHeight(0.1)
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray,
                                frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.width, height: self.view.frame.height),
                                pageMenuOptions: parameters)
        
        
        pageMenu!.delegate = self
        
        self.view.addSubview(pageMenu!.view)
        
    }
}
