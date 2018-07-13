//
//  contentTmiVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 8..
//

import UIKit

class ContentTmiVC: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource, APIService {
    
    @IBOutlet weak var tmiCollectionView: UICollectionView!
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentTmidInit(url: url("/contents/main/TMI"))
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tmiCollectionView.refreshControl = UIRefreshControl()
        self.tmiCollectionView.refreshControl?.addTarget(self, action: #selector(startReloadTableView(_:)), for: .valueChanged)
        tmiCollectionView.delegate = self
        tmiCollectionView.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var tmiContents: [RecommendVODataContent]?
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
    //var contentMenus = ContentMenuData.sharedInstance.contentMenus
    //----------------collectionView------------------
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            if let tmiData_ = tmiContents {
                return tmiData_.count
            }
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TmiFirstCell.reuseIdentifier, for: indexPath) as! TmiFirstCell            //cell에 데이터 연결!
            
            if let tmicontents_ = tmiContents{
                cell.configure(data: tmicontents_[indexPath.row])
            }
            
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TmiSecondCell.reuseIdentifier, for: indexPath) as! TmiSecondCell
            //cell에 데이터 연결!
            
            if let tmiContents_ = tmiContents{
                cell.configure(data: tmiContents_[indexPath.row])
            }
            cell.tmiImgView.layer.cornerRadius = 10
            cell.tmiImgView.layer.masksToBounds = true
            return cell
        }
    }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if indexPath.section == 0 {
                
                let detailVC = Storyboard.shared().contentStoryboard.instantiateViewController(withIdentifier: ContentDetailVC.reuseIdentifier) as! ContentDetailVC
                //pass data
                if let contentData_ = tmiContents {
                    detailVC.contentIdx = contentData_[indexPath.row].contentsid
                }
                //화면전환
                self.navigationController?.pushViewController(detailVC, animated: true)
            }else {
                let detailVC = Storyboard.shared().contentStoryboard.instantiateViewController(withIdentifier: ContentDetailVC.reuseIdentifier) as! ContentDetailVC
                //passData
                if let contentData_ = tmiContents {
                    detailVC.contentIdx = contentData_[indexPath.row].contentsid
                }
                //화면전환
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
extension ContentTmiVC {
    
    @objc func startReloadTableView(_ sender: UIRefreshControl){
        contentTmidInit(url: url("/contents/main/TMI"))
    
        sender.endRefreshing()
    }
}


extension ContentTmiVC {
    //extension에서 이름 바꾸고
    
    func contentTmidInit(url : String){ //contentTmiInit 이름 바꾸고
        RecommendService2.shareInstance.getRecommendContent(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let tmiData):
                let recommendData = tmiData as! RecommendVOData
                self.tmiContents = recommendData.content
                self.alarmCount = recommendData.alarmcnt // 알림 lbl
                self.tmiCollectionView.reloadData()
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



