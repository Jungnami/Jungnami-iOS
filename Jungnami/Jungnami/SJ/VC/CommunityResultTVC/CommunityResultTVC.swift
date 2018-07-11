//
//  CommunityResultTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 4..
//

import UIKit

class CommunityResultTVC: UITableViewController, APIService {
    
    @IBOutlet weak var searchTxtfield: UITextField!
    @IBOutlet weak var separateView: UIView!
    var communitySearchData : [CommunitySearchVOData] = []
    var searchString : String?
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
        searchTxtfield.text = searchString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

//데이터소스, 딜리게이트 
extension CommunityResultTVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return communitySearchData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommunityResultTVCell.reuseIdentifier) as! CommunityResultTVCell
       
        cell.configure(index : indexPath.row, data: communitySearchData[indexPath.row])
        cell.delegate = self
        cell.scrapBtn.tag = indexPath.row
        cell.scrapBtn.isUserInteractionEnabled = true
        cell.scrapBtn.addTarget(self, action: #selector(scrap(sender:)), for: .touchUpInside)
        
        return cell
        
    }
    
    @objc func scrap(sender : UIButton){
        
        //다른 뷰로 넘길때 userId 같이 넘기면 (나중에는 댓글에 대한 고유 인덱스가 됨) 그거 가지고 다시 통신
        //let userName = sampleData[sender.tag].name
        simpleAlertwithHandler(title: "스크랩", message: "스크랩하시겠습니까?") { (_) in
            // print(userName)
        }
    }
    
}


//키보드 엔터 버튼 눌렀을 때
extension CommunityResultTVC : UITextFieldDelegate {
    
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
        
      //  textField.resignFirstResponder()
       
        //여기서 검색
        if let searchString_ = textField.text {
            searchCommunity(searchString : searchString_, url : url("/search/board/\(searchString_)"))
        }
        
        
        return true
    }
}


//키보드 대응
extension CommunityResultTVC{
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

//탭제스처 레코그나이저
extension CommunityResultTVC :  UIGestureRecognizerDelegate, TapDelegate {
    func myTableDelegate(index: Int) {
        print(index)
    }
   
}

//통신
extension CommunityResultTVC {
    //커뮤 검색
    func searchCommunity(searchString : String, url : String){
        CommunitySearchService.shareInstance.searchBoard(url: url) { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let communitySearchData):
                let communitySearchData = communitySearchData as! [CommunitySearchVOData]
                self.communitySearchData = communitySearchData
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


