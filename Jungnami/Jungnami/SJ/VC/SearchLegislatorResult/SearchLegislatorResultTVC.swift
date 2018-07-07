//
//  SearchLegislatorResultTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 3..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class SearchLegislatorResultTVC: UITableViewController {

    var searchString : String?
    var sampleData : [SampleLegislator] = []
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
        
        //////////////////////뷰 보기 위한 샘플 데이터//////////////////////////
        let a = SampleLegislator(profile: #imageLiteral(resourceName: "dabi"), name: "김성태", likeCount: 12, dislikeCount: 45, region: "서울 강서구 을", party : .blue)
        let b = SampleLegislator(profile: #imageLiteral(resourceName: "dabi"), name: "정다비", likeCount: 12, dislikeCount: 45, region: "당대표, 서울 광진구 을", party : .red)
        let c = SampleLegislator(profile: #imageLiteral(resourceName: "dabi"), name: "강수진", likeCount: 12, dislikeCount: 45, region: "서울 강서구 을", party : .blue)
        let d = SampleLegislator(profile: #imageLiteral(resourceName: "dabi"), name: "정다비", likeCount: 12, dislikeCount: 45, region: "당대표, 서울 광진구 을", party : .yellow)
        let e = SampleLegislator(profile: #imageLiteral(resourceName: "dabi"), name: "이지현", likeCount: 12, dislikeCount: 45, region: "서울 강서구 을", party : .orange)
        let f = SampleLegislator(profile: #imageLiteral(resourceName: "dabi"), name: "명선", likeCount: 12, dislikeCount: 45, region: "당대표, 서울 광진구 을", party : .mint)
        sampleData.append(a)
        sampleData.append(b)
        sampleData.append(contentsOf: [c,d,e,f])
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let legislatorDetailVC = self.storyboard?.instantiateViewController(withIdentifier:LegislatorDetailVC.reuseIdentifier) as? LegislatorDetailVC {
         
            legislatorDetailVC.selectedLegislator = self.sampleData[indexPath.row]
            
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
        
        textField.resignFirstResponder()
        //TODO - 확인 누르면 데이터 로드하는 통신 코드
        //있으면 리로드, 없으면 얼러트
        
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
