//
//  ContentRecommendVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 8..
//

import UIKit

protocol AlarmProtocol {
    func getAlarm(alarmCount : Int)
}

class ContentRecommendVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, APIService {
    
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentCollectionView.refreshControl = UIRefreshControl()
        self.contentCollectionView.refreshControl?.addTarget(self, action: #selector(startReloadTableView(_:)), for: .valueChanged)
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
        //통신
        contentRecommendInit(url: url("/contents/recommend"))
        
    }
    var contentData : [RecommendVODataContent]?
    var alarmDelegate  : AlarmProtocol?
    var alarmCount : Int? {
        didSet {
            if let alarmCount_ = alarmCount {
                print("alarmCount changed!")
                print(alarmCount_)
                self.alarmDelegate?.getAlarm(alarmCount: alarmCount_)
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //-------------------collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            if let recommendData_ = contentData {
                return recommendData_.count
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = contentCollectionView.dequeueReusableCell(withReuseIdentifier: RecommendFirstCell.reuseIdentifier, for: indexPath) as! RecommendFirstCell
            //통신
            if let tmicontents_ = contentData{
                cell.configure(data: tmicontents_[indexPath.row])
            }
            return cell
        }else {
            let cell = contentCollectionView.dequeueReusableCell(withReuseIdentifier: RecommendSecondCell.reuseIdentifier, for: indexPath) as! RecommendSecondCell
            //통신
            if let tmiContents_ = contentData{
                cell.configure(data: tmiContents_[indexPath.row])
            }
            cell.contentImgView.layer.cornerRadius = 10
            cell.contentImgView.layer.masksToBounds = true
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
        let detailVC = Storyboard.shared().contentStoryboard.instantiateViewController(withIdentifier: ContentDetailVC.reuseIdentifier) as! ContentDetailVC
        if let contentData_ = contentData {
            detailVC.contentIdx = contentData_[indexPath.row].contentsid
        }
            self.navigationController?.pushViewController(detailVC, animated: true)
        }else {
            let detailVC = Storyboard.shared().contentStoryboard.instantiateViewController(withIdentifier: ContentDetailVC.reuseIdentifier) as! ContentDetailVC
            if let contentData_ = contentData {
                detailVC.contentIdx = contentData_[indexPath.row].contentsid
            }
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    //--------collectionView Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: self.view.frame.width, height: 257)
        }else {
            return CGSize(width: 170, height: 187)
        }
        
    }
    //세로간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else{
            return 6
        }
    }
    //가로간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }else {
            return 7.5
        }
    }
    //section과 collectionView사이 간격 - (top, left, bottom, right)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else {
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    }
    

}

//리프레시
extension ContentRecommendVC {
    
    @objc func startReloadTableView(_ sender: UIRefreshControl){
         contentRecommendInit(url: url("/contents/recommend"))
        sender.endRefreshing()
    }
}

//통신

extension ContentRecommendVC {
    
    func contentRecommendInit(url : String){
        RecommendService2.shareInstance.getRecommendContent(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let recommendData):
                let recommendData = recommendData as! RecommendVOData
                self.contentData = recommendData.content
                self.alarmCount = recommendData.alarmcnt
                self.contentCollectionView.reloadData()
                break
            case .nullValue :
                self.simpleAlert(title: "오류", message: "값 없음")
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
        
    }
}


