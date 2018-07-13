//
//  ContentStoryVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 8..
//

import UIKit

class ContentStoryVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, APIService {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyCollectionView.dataSource = self
        storyCollectionView.delegate = self
        self.storyCollectionView.refreshControl = UIRefreshControl()
        self.storyCollectionView.refreshControl?.addTarget(self, action: #selector(startReloadTableView(_:)), for: .valueChanged)
        let story = "스토리"
        contentStorydInit(url: url("/contents/main/\(story)"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBOutlet weak var storyCollectionView: UICollectionView!
    
    var storyData: [RecommendVODataContent]?
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
    
    //-------------------collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            if let storyData_ = storyData {
                return storyData_.count
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        

        if indexPath.section == 0 {
            let cell = storyCollectionView.dequeueReusableCell(withReuseIdentifier: StoryFirstCell.reuseIdentifier, for: indexPath) as! StoryFirstCell            //cell에 데이터 연결!
            //통신
            if let storyContents_ = storyData{
                cell.configure(data: storyContents_[0])
            }
            return cell
        }else {
            let cell = storyCollectionView.dequeueReusableCell(withReuseIdentifier: StorySecondCell.reuseIdentifier, for: indexPath) as! StorySecondCell
            //cell에 데이터 연결!
            //통신
            if let storyContents_ = storyData {
                cell.configure(data: storyContents_[indexPath.row])
            }
            cell.storyImgView.layer.cornerRadius = 10
            cell.storyImgView.layer.masksToBounds = true
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let detailVC = Storyboard.shared().contentStoryboard.instantiateViewController(withIdentifier: ContentDetailVC.reuseIdentifier) as! ContentDetailVC
            if let storyData_ = storyData {
                detailVC.contentIdx = storyData_[indexPath.row].contentsid
            }
            self.navigationController?.pushViewController(detailVC, animated: true)
        }else {
            let detailVC = Storyboard.shared().contentStoryboard.instantiateViewController(withIdentifier: ContentDetailVC.reuseIdentifier) as! ContentDetailVC
            if let storyData_ = storyData {
                detailVC.contentIdx = storyData_[indexPath.row].contentsid
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
extension ContentStoryVC {
    
    @objc func startReloadTableView(_ sender: UIRefreshControl){
       contentStorydInit(url: url("/contents/main/스토리"))
        sender.endRefreshing()
    }
}

extension ContentStoryVC {
    //extension에서 이름 바꾸고
    
    func contentStorydInit(url : String){ //contentTmiInit 이름 바꾸고
        RecommendService2.shareInstance.getRecommendContent(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let storyData):
                let storyData = storyData as! RecommendVOData
                self.storyData = storyData.content.filter({
                    $0.type == 0
                })
                self.alarmCount = storyData.alarmcnt // 알림 lbl
                self.storyCollectionView.reloadData()
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
