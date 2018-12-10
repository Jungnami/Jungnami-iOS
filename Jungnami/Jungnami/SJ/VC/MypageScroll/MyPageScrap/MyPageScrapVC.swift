//
//  MyPageScrapVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 8. 7..
//

import UIKit
import LTScrollView

class MyPageScrapVC : UIViewController, LTTableViewProtocal, APIService  {
    
    var myScrapData : [MyPageVODataScrap]  = [] {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    private let glt_iphoneX = (UIScreen.main.bounds.height == 812.0)
    
    private lazy var collectionView: UICollectionView = {
        let H: CGFloat = glt_iphoneX ? (view.bounds.height - 64 - 24 - 34) : view.bounds.height  - 20
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 170, height: 187)
        layout.minimumLineSpacing = 13
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
       let collectionView = collectionViewConfig(CGRect(x: 0, y: 0, width: view.bounds.width, height: H), layout, self, self)
        return collectionView
    }()
    
    func collectionViewConfig(_ frame: CGRect, _ collectionViewLayout : UICollectionViewLayout, _ delegate: UICollectionViewDelegate, _ dataSource: UICollectionViewDataSource) -> UICollectionView {
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .white
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        return collectionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "MyPageScrapCVCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "MyPageScrapCVCell")
         view.addSubview(collectionView)
        glt_scrollView = collectionView
        
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
}

//CollectionView Delegate, Datasource
extension MyPageScrapVC : UICollectionViewDelegate, UICollectionViewDataSource  {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return myScrapData.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageScrapCVCell.reuseIdentifier, for: indexPath) as! MyPageScrapCVCell
        
        //configure로
        cell.configure(data: myScrapData[indexPath.row])
        //cell의 이미지 radius
        cell.scrapImgView.layer.cornerRadius = 10
        cell.scrapImgView.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goToDetail(index: myScrapData[indexPath.row].cID )
    }
    
}

//통신
extension MyPageScrapVC {
    func goToDetail(index : Int){
        let detailVC = Storyboard.shared().contentStoryboard.instantiateViewController(withIdentifier: ContentDetailVC.reuseIdentifier) as! ContentDetailVC
        
        detailVC.contentIdx = index
        self.present(detailVC, animated: true)
    }
    
}

