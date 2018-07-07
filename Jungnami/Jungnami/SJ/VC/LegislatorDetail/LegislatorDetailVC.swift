//
//  LegislatorDetailVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 7..
//

import UIKit


class LegislatorDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var legislatorCollectionView: UICollectionView!
    var selectedLegislator : SampleLegislator?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        setupBackBtn()
        
        
        
        legislatorCollectionView.delegate = self
        legislatorCollectionView.dataSource = self
        
    }
    var contents = LegislatorContentData.sharedInstance.legislatorContents
    var data = LegislatorData.sharedInstance.legislators
    
}

//백버튼 커스텀과 액션 추가
extension LegislatorDetailVC {
    func setupBackBtn(){
        let backBtn = UIButton(type: .system)
        backBtn.setImage(#imageLiteral(resourceName: "area_left_arrow").withRenderingMode(.alwaysOriginal), for: .normal)
        backBtn.addTarget(self, action:  #selector(self.toBack(_sender:)), for: .touchUpInside)
        backBtn.snp.makeConstraints { (make) in
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
    }
    
    @objc func toBack(_sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

//collectionView datasource, delegate
extension LegislatorDetailVC {
    //--------------collectionView-------------
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return 1
        }else {
            //샘플데이터 넣고 .count넣기!
            return contents.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LegislatorProfileCell.reuseIdentifier, for: indexPath) as! LegislatorProfileCell
            if let selectedLegislator_ = selectedLegislator {
                cell.configure(data: selectedLegislator_)
            }
            
            //            cell.legislatorProfileImgView.layer.cornerRadius = 10
            //투두 - 이미지 안뜨고 border도 안뜸 ㅠㅠ
           
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LegislatorRelatedCell.reuseIdentifier, for: indexPath) as! LegislatorRelatedCell
            cell.fixedLbl.text = "관련된 컨텐츠"
            return cell
        } else  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LegislatorContentCell.reuseIdentifier, for: indexPath) as! LegislatorContentCell
            //투두 - 샘플데이터 만들고 configure연결하기
            cell.configure(data: contents[indexPath.row])
            cell.legislatorContentImgView.layer.cornerRadius = 10
            cell.legislatorContentImgView.layer.masksToBounds = true
            
            return cell
        }
        
    }
}

//collection View cell 레이아웃
extension LegislatorDetailVC {
    //layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: 375, height: 183)
        }
        if indexPath.section == 1 {
            return CGSize(width: 375, height: 54)
        }else {
            return CGSize(width: 170, height: 187)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 && section == 1 {
            return 0
        }else {
            return 14
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 && section == 1{
            return 0
        }else {
            return 12
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 && section == 1 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }else {
            return UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        }
    }
}
