//
//  ContentSearchResultVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 13..
//

import UIKit

class ContentSearchResultVC: UIViewController {
    
    

    @IBOutlet weak var contentSearchResultCollectionView: UICollectionView!
    
    var sampleData = ContentSearchResultData.sharedInstance.resultData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentSearchResultCollectionView.delegate = self
        contentSearchResultCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ContentSearchResultVC:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = contentSearchResultCollectionView.dequeueReusableCell(withReuseIdentifier: ContentSearchResultCell.reuseIdentifier, for: [indexPath.row]) as! ContentSearchResultCell
        cell.configure(data: sampleData[indexPath.row])
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
