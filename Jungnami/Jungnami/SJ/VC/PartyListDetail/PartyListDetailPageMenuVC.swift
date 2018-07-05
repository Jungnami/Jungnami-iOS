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
    var keyboardDismissGesture: UITapGestureRecognizer?
    lazy var navSearchView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var searchGrayView : UIImageView = {
        let imgView = UIImageView()
        
        imgView.image = #imageLiteral(resourceName: "community_search_field")
        return imgView
    }()
    
    lazy var searchView : UIImageView = {
        let imgView = UIImageView()
        
        imgView.image = #imageLiteral(resourceName: "community_search")
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
    
     var selectedParty : PartyList?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
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


//네비게이션 기본바 커스텀
extension PartyListDetailPageMenuVC {
  
    @objc func setDefaultNav(){
        self.navigationItem.titleView = nil
        self.navigationItem.setHidesBackButton(true, animated:true)
        navigationItem.title = "정당"
        navigationController?.navigationBar.isTranslucent = false
        
        ////setupLeftNavItem
        let backBtn = UIButton(type: .system)
        backBtn.setImage(#imageLiteral(resourceName: "community_left_arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        backBtn.addTarget(self, action:  #selector(PartyListDetailPageMenuVC.toBack(_sender:)), for: .touchUpInside)
        backBtn.snp.makeConstraints { (make) in
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)

        //setupRightNavItem
        let searchBtn = UIButton(type: .system)
        searchBtn.setImage(#imageLiteral(resourceName: "partylist_search").withRenderingMode(.alwaysOriginal), for: .normal)
        searchBtn.snp.makeConstraints { (make) in
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        searchBtn.addTarget(self, action:  #selector(PartyListDetailPageMenuVC.search(_sender:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBtn)
    
      
        
    }
    
    
    
}

//기본 네비게이션 바에서 오른쪽/왼쪽 아이템에 대한 행동
extension PartyListDetailPageMenuVC {
   
    @objc public func toBack(_sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @objc public func search(_sender: UIButton) {
        //self.navigationItem.backBarButtonItem?.isEnabled = false
        self.navigationItem.leftBarButtonItem = nil
        makeSearchBarView()
    }

}

//네비게이션 서치바 커스텀
extension PartyListDetailPageMenuVC{
    func makeSearchBarView() {
        navSearchView.snp.makeConstraints { (make) in
            make.width.equalTo(311)
            make.height.equalTo(31)
            // make.leading.equalTo(self.)
        }
        navSearchView.addSubview(searchGrayView)
        navSearchView.addSubview(searchView)
        navSearchView.addSubview(searchTxtField)
        
        searchGrayView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.equalTo(navSearchView)
        }
        
        searchView.snp.makeConstraints { (make) in
            make.leading.equalTo(searchGrayView).offset(10)
            make.width.height.equalTo(15)
            make.centerY.equalTo(searchGrayView)
        }
        
        searchTxtField.snp.makeConstraints { (make) in
            make.top.bottom.trailing.equalTo(searchGrayView)
            make.leading.equalTo(searchView.snp.trailing).offset(8)
        }
        
        searchTxtField.delegate = self
        navigationItem.titleView = navSearchView
        navigationController?.navigationBar.isTranslucent = false
        
        //rightBarBtn
        let rightBarButton = customBarbuttonItem(title: "취소", red: 112, green: 112, blue: 112, fontSize: 14, selector: #selector(setDefaultNav))
        
        navigationItem.rightBarButtonItem = rightBarButton
    }
}

//txtField Delegate (엔터버튼 클릭시)
extension PartyListDetailPageMenuVC : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            simpleAlert(title: "오류", message: "검색어 입력")
            return false
        }
        
        if let myString = textField.text {
            let emptySpacesCount = myString.components(separatedBy: " ").count-1
            
            if emptySpacesCount == myString.count {
                simpleAlert(title: "오류", message: "검색어 입력")
                return false
            }
        }
        searchLegislator()
        return true
    }
}

//키보드 대응
extension PartyListDetailPageMenuVC{
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
        // setDefaultNav()
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
