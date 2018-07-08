//
//  CommunityResultTVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 4..
//

import UIKit

class CommunityResultTVC: UITableViewController {
    
    @IBOutlet weak var searchTxtfield: UITextField!
    @IBOutlet weak var separateView: UIView!
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
    
    var sampleData : [Sample] = []
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
        //////////////////////뷰 보기 위한 샘플 데이터//////////////////////////
        
        let a = Sample(profileUrl: #imageLiteral(resourceName: "dabi"), name: "다비다비", time: "1시간 전", content: "다비 최고야,, 형윤 최고야,, 디자인 세상에서 제일 예뻐요 선생님들,, ", like: 3, comment: 5, contentImg: nil, heart: true, scrap: false)
        let b = Sample(profileUrl: #imageLiteral(resourceName: "community_character"), name: "제리", time: "4시간 전", content: "픽미픽미픽미업", like: 73, comment: 6020, contentImg: #imageLiteral(resourceName: "inni"), heart: false, scrap: true)
        
        sampleData.append(a)
        sampleData.append(b)
        ////////////////////////////////////////////////////
        
    }
    
    
}

//데이터소스, 딜리게이트 
extension CommunityResultTVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sampleData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommunityTVCell.reuseIdentifier) as! CommunityTVCell
        
        cell.configure(index : indexPath.row, data: sampleData[indexPath.row])
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
        
        textField.resignFirstResponder()
        //TODO - 확인 누르면 데이터 로드하는 통신 코드
        //있으면 리로드, 없으면 얼러트
        
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



