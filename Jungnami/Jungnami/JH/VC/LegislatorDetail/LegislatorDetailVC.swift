//
//  LegislatorDetailVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 7..
//

import UIKit

class LegislatorDetailVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //--------------collectionView-------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        if section == 1 {
            return 1
        }else {
            //샘플데이터 넣고 .count넣기!
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LegislatorProfileCell.reuseIdentifier, for: indexPath) as! LegislatorProfileCell
            //configure로 연결하기!
            return cell
        }
        if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LegislatorRelatedCell.reuseIdentifier, for: indexPath) as! LegislatorRelatedCell
            //투두 - cell.fixedLbl.text = "관련된 컨텐츠"
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LegislatorContentCell.reuseIdentifier, for: indexPath) as! LegislatorContentCell
            //투두 - 샘플데이터 만들고 configure연결하기
            return cell
        }
    }
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
          return UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        }
    }

}
