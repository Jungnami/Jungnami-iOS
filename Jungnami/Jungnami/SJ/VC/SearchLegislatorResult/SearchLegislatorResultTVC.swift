//
//  SearchLegislatorResultTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 3..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class SearchLegislatorResultTVC: UITableViewController, APIService {
    
    //viewFrom - 300명 나와야할때 0, 정당에서 나와야할때 1, 지역에서 나와야할 때 2
    var viewFrom : Int = 0
    var selectedParty : PartyName?
    var selectedRegion : Region?
    var searchString : String?
    var legislatorSearchData : [LegislatorSearchVOData] = []
    @IBOutlet weak var separateView: UIView!
    @IBOutlet weak var searchTxtfield: UITextField!
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    lazy var blackView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.4
        return view
    }()
    
    
    var keyboardDismissGesture: UITapGestureRecognizer?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        searchTxtfield.text = searchString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        searchTxtfield.delegate = self
        setKeyboardSetting()
        
        self.tableView.addSubview(blackView)
        blackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(separateView.snp.top)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            
        }
        blackView.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchTxtfield.resignFirstResponder()
    }
    
}

//tableview delegate, datasource
extension SearchLegislatorResultTVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return legislatorSearchData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchLegislatorResultTVCell.reuseIdentifier) as! SearchLegislatorResultTVCell
        let rank = indexPath.row+1
        cell.configure(rank: rank, data: legislatorSearchData[indexPath.row])
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let legislatorDetailVC = self.storyboard?.instantiateViewController(withIdentifier:LegislatorDetailVC.reuseIdentifier) as? LegislatorDetailVC {
            
            legislatorDetailVC.selectedLegislatorIdx = self.legislatorSearchData[indexPath.row].id
            legislatorDetailVC.selectedLegislatorName = self.legislatorSearchData[indexPath.row].name
            self.navigationController?.pushViewController(legislatorDetailVC, animated: true)
        }
        
    }
    
}


//키보드 엔터 버튼 눌렀을 때
extension SearchLegislatorResultTVC : UITextFieldDelegate {
    
    //텍필 비어잇으면 막기
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
        
       // textField.resignFirstResponder()
        
        //있으면 리로드, 없으면 얼러트
        if let searchString_ = textField.text {
            if viewFrom == 0 {
                // /search/legislator/:l_name -> 300명
                searchLegislator(searchString : searchString_, url : UrlPath.SearchLegislator.getURL(searchString_))
                
            } else if viewFrom == 1 {
                // /search/legislatorparty/:p_name/:l_name  -> 정당
                
                searchLegislator(searchString : searchString_, url : UrlPath.PartyLegislatorList.getURL("\(selectedParty!.rawValue)/search/\(searchString_)"))
                
                
            } else {
                // /search/legislatorregion/:city/:l_name  -> 지역
                searchLegislator(searchString : searchString_, url :
                    UrlPath.RegionLegislatorList.getURL("\(selectedRegion!.rawValue)/search/\(searchString_)"))
            }
        }
        
        return true
    }
}


//키보드 대응
extension SearchLegislatorResultTVC{
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
        //내 텍필
        self.view.endEditing(true)
    }
}


//통신
extension SearchLegislatorResultTVC {
    //의원검색
    func searchLegislator(searchString : String, url : String){
        LegislatorSearchService.shareInstance.searchLegislator(url: url) { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let legislatorData):
                //dddddddd
                let legislatorSearchData = legislatorData as! [LegislatorSearchVOData]
                self.legislatorSearchData = legislatorSearchData
                self.searchTxtfield.resignFirstResponder()
                self.tableView.reloadData()
                break
            case .nullValue :
                self.simpleAlert(title: "오류", message: "검색 결과가 없습니다")
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
        }
    }
    
   
}




