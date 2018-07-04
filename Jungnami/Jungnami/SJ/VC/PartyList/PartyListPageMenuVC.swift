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
    var keyboardDismissGesture: UITapGestureRecognizer?
    lazy var navSearchView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var searchGrayView : UIImageView = {
        let imgView = UIImageView()
        
        imgView.image = #imageLiteral(resourceName: "partylist_search_field")
        return imgView
    }()
    
    
    lazy var searchTxtField : UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "찾고 싶은 국회의원을 검색해보세요"
        txtField.font = UIFont.systemFont(ofSize: 14.0)
        return txtField
    }()
    
    lazy var blackView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.4
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setKeyboardSetting()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchTxtField.delegate = self
        setupPageMenu()
        setDefaultNav()
        blackView.isHidden = true
        self.view.addSubview(blackView)
        blackView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func searchLegislator(){
         if let searchLegislatorResultTVC = self.storyboard?.instantiateViewController(withIdentifier:SearchLegislatorResultTVC.reuseIdentifier) as? SearchLegislatorResultTVC {
             self.navSearchView.endEditing(true)
            //searchLegislatorResultTVC = self.selectedCategory
            self.navigationController?.pushViewController(searchLegislatorResultTVC, animated: true)
        }
        
    }
}

//페이지 메뉴 라이브러리 커스텀
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

//네비게이션 기본바 커스텀
extension PartyListPageMenuVC {
    
    func setDefaultNav(){
        setupTitleNavImg()
        setupLeftNavItem()
        setupRightNavItem()
    }
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

//기본 네비게이션 바에서 오른쪽/왼쪽 아이템에 대한 행동
extension PartyListPageMenuVC {
    @objc public func toMyPage(_sender: UIButton) {
        //1. 나중에 goFirst 했던 것처럼 해당 뷰로 exit 바로 할수 있도록 하기
    }
    
    @objc public func search(_sender: UIButton) {
        makeSearchBarView()
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
    }
}

//네비게이션 서치바 커스텀
extension PartyListPageMenuVC{
    func makeSearchBarView() {
        searchGrayView.contentMode = .scaleAspectFit
        
        navSearchView.snp.makeConstraints { (make) in
            make.width.equalTo(316)
            make.height.equalTo(31)
        }
        navSearchView.addSubview(searchGrayView)
        navSearchView.addSubview(searchTxtField)
        
        searchGrayView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalTo(navSearchView)
        }
        
        searchTxtField.snp.makeConstraints { (make) in
            make.top.bottom.trailing.equalTo(searchGrayView)
            make.leading.equalTo(searchGrayView).offset(30)
        }
        
        searchTxtField.delegate = self
        navigationItem.titleView = navSearchView
        navigationController?.navigationBar.isTranslucent = false
    }
    
}

//txtField Delegate (엔터버튼 클릭시)
extension PartyListPageMenuVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchLegislator()
        return true
    }
}

//키보드 대응
extension PartyListPageMenuVC{
    func setKeyboardSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        blackView.isHidden = false
        adjustKeyboardDismissGesture(isKeyboardVisible: true)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        blackView.isHidden = true
        searchTxtField.text = ""
        setDefaultNav()
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
    
    }
    
    //화면 바깥 터치했을때 키보드 없어지는 코드
    func adjustKeyboardDismissGesture(isKeyboardVisible: Bool) {
        if isKeyboardVisible {
            if keyboardDismissGesture == nil {
                keyboardDismissGesture = UITapGestureRecognizer(target: self, action: #selector(tapBackground))
                view.addGestureRecognizer(keyboardDismissGesture!)
            }
        } else {
            if keyboardDismissGesture != nil {
                view.removeGestureRecognizer(keyboardDismissGesture!)
                keyboardDismissGesture = nil
            }
        }
    }
    
    @objc func tapBackground() {
       self.navSearchView.endEditing(true)
    }
}


