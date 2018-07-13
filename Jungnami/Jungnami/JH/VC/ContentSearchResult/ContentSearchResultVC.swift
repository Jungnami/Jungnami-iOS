//
//  ContentSearchResultVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 13..
//

import UIKit

class ContentSearchResultVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    

    @IBOutlet weak var contentSearchResultCollectionView: UICollectionView!
    
    var sampleData = ContentSearchResultData.sharedInstance.resultData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentSearchResultCollectionView.delegate = self
        contentSearchResultCollectionView.dataSource = self
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = contentSearchResultCollectionView.dequeueReusableCell(withReuseIdentifier: ContentSearchResultCell.reuseIdentifier, for: indexPath) as! ContentSearchResultCell
        cell.configure(data: sampleData[indexPath.row])
        
        cell.contentImgView.layer.cornerRadius = 10
        cell.contentImgView.layer.masksToBounds = true
        
        return cell
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
