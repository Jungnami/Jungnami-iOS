//
//  ContentContainerVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 8..
//

import UIKit

class ContentContainerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var contentMenus = ContentMenuData.sharedInstance.contentMenus
}
extension ContentContainerVC {
    
    //-------------------collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            
            return contentMenus.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentFirstCell.reuseIdentifier, for: indexPath) as! ContentFirstCell            //cell에 데이터 연결!
            cell.configure(data: contentMenus[indexPath.row])
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentSecondCell.reuseIdentifier, for: indexPath) as! ContentSecondCell
            //cell에 데이터 연결!
            cell.configure(data: contentMenus[indexPath.row])
            cell.contentImgView.layer.cornerRadius = 10
            cell.contentImgView.layer.masksToBounds = true
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //item을 누르면 contentDetailVC로 pushViewController로 넘겨야 함
        //        performSegue(withIdentifier: "goToContnetDetail", sender: AnyObject.self)
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
