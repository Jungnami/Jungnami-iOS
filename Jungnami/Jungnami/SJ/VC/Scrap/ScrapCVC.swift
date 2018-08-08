////
////  ScrapCVC.swift
////  Jungnami
////
////  Created by 이지현 on 2018. 7. 4..
////
//
////지우고 정리
//import UIKit
//
//class ScrapCVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//
//    var myScrapData : [MyPageVODataScrap]  = [] {
//        didSet {
//            self.collectionView?.reloadData()
//        }
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//    }
//
//
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//
//        return myScrapData.count
//    }
//
//
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScrapCell.reuseIdentifier, for: indexPath) as! ScrapCell
//
//        //configure로
//        cell.configure(data: myScrapData[indexPath.row])
//        //cell의 이미지 radius
//        cell.scrapImgView.layer.cornerRadius = 10
//        cell.scrapImgView.layer.masksToBounds = true
//        return cell
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("aaaaaaaaaaaaa")
//        goToDetail(index: myScrapData[indexPath.row].cID )
//    }
//
//
//     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: 170, height: 187)
//
//    }
//    //section내의
//        //-간격 위아래
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 13
//    }
//        //-간격 왼쪽오른쪽
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 12
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsetsMake(10, 10, 10, 10)
//    }
//
//
//
//}
//
////통신
//extension ScrapCVC {
//    func goToDetail(index : Int){
//        let detailVC = Storyboard.shared().contentStoryboard.instantiateViewController(withIdentifier: ContentDetailVC.reuseIdentifier) as! ContentDetailVC
//
//            detailVC.contentIdx = index
//        self.present(detailVC, animated: true)
//    }
//
//}
//
