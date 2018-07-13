//
//  ContentSearchResultVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 13..
//

import UIKit
import SnapKit

class ContentSearchResultVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, APIService {
    
    
    var contendSearchData : [ContentSearchVOData]?
    var searchString : String?
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var contentSearchResultCollectionView: UICollectionView!
    
    @IBOutlet weak var searchTxtField: UITextField!
    
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
        searchTxtField.text = searchString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTxtField.delegate = self
        setKeyboardSetting()
        
        self.contentSearchResultCollectionView.addSubview(blackView)
        blackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(self.navView.snp.bottom)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            
        }
        
        blackView.isHidden = true
        
        
        contentSearchResultCollectionView.delegate = self
        contentSearchResultCollectionView.dataSource = self
      
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchTxtField.resignFirstResponder()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let contendSearchData_ = contendSearchData {
            return contendSearchData_.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = contentSearchResultCollectionView.dequeueReusableCell(withReuseIdentifier: ContentSearchResultCell.reuseIdentifier, for: indexPath) as! ContentSearchResultCell
        
        
        
        if let contendSearchData_ = contendSearchData {
            cell.contentImgView.layer.cornerRadius = 10
            cell.contentImgView.layer.masksToBounds = true
             cell.configure(data: contendSearchData_[indexPath.row])
            
        }
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
            if let contendSearchData_ = contendSearchData {
                let contentIdx = contendSearchData_[indexPath.row].contentsid
                let detailVC = Storyboard.shared().contentStoryboard.instantiateViewController(withIdentifier: ContentDetailVC.reuseIdentifier) as! ContentDetailVC
                
                detailVC.contentIdx = contentIdx
                self.present(detailVC, animated: true)
            }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 170, height: 187)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7.5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
}

//키보드 엔터 버튼 눌렀을 때
extension ContentSearchResultVC : UITextFieldDelegate {
    
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
            self.searchContent(url: url("/search/contents/\(searchString_)"))
        }
        
        return true
    }
}


//키보드 대응
extension ContentSearchResultVC{
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
extension ContentSearchResultVC {
    func searchContent(url : String){
        ContentSearchService.shareInstance.searchContent(url: url) { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let contentData):
                let contentSearchData = contentData as! [ContentSearchVOData]
                
                self.contendSearchData = contentSearchData
                self.searchTxtField.resignFirstResponder()
                self.contentSearchResultCollectionView.reloadData()
                
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

