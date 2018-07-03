//
//  PartyListPageMenuVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 3..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit
import PageMenu
import SnapKit

class PartyListPageMenuVC: UIViewController, CAPSPageMenuDelegate {
    var pageMenu: CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageMenu()
        setupTitleNavImg()
        setupLeftNavItem()
        setupRightNavItem()
        
    }
}

//페이지 메뉴
extension PartyListPageMenuVC {
    func setupPageMenu(){
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        var controllerArray : [UIViewController] = []
        
        let partyListTVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: PartyListTVC.reuseIdentifier) as! PartyListTVC
        partyListTVC.title = "정당"
        controllerArray.append(partyListTVC)
        
        
        let regionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: RegionVC.reuseIdentifier) as! RegionVC
        regionVC.title = "지역"
        controllerArray.append(regionVC)
        
        
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

//네비게이션 바 커스텀
extension PartyListPageMenuVC {
    func setupTitleNavImg(){
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "partylist_logo"))
        titleImageView.contentMode = .scaleAspectFit
        titleImageView.snp.makeConstraints { (make) in
            make.height.equalTo(21)
            make.width.equalTo(52)
        }
        
        navigationItem.titleView = titleImageView
        navigationController?.navigationBar.isTranslucent = false
    }
    func setupLeftNavItem(){
        let myPageBtn = UIButton(type: .system)
        myPageBtn.setImage(#imageLiteral(resourceName: "partylist_mypage").withRenderingMode(.alwaysOriginal), for: .normal)
        myPageBtn.addTarget(self, action:  #selector(PartyListPageMenuVC.toMyPage(_sender:)), for: .touchUpInside)
        myPageBtn.snp.makeConstraints { (make) in
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: myPageBtn)
    }
    func setupRightNavItem(){
        let searchBtn = UIButton(type: .system)
        searchBtn.setImage(#imageLiteral(resourceName: "partylist_search").withRenderingMode(.alwaysOriginal), for: .normal)
        searchBtn.snp.makeConstraints { (make) in
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        searchBtn.addTarget(self, action:  #selector(PartyListPageMenuVC.search(_sender:)), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBtn)
    }
}

//네비게이션 바 버튼 눌렀을 때 각각
extension PartyListPageMenuVC {
    @objc public func toMyPage(_sender: UIButton) {
        //1. 나중에 goFirst 했던 것처럼 해당 뷰로 exit 바로 할수 있도록 하기
    }
    
    @objc public func search(_sender: UIButton) {
        //1. 네이게이션 바 다시 커스텀 해서 텍스트필드랑, 확인 버튼 나오도록
        //2. 키보드 나오도록 -> 키보드에 대한 이벤트도 추가
        //3. 검정 화면 나오도록
    }
}
