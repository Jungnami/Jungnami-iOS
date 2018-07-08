//
//  ContentDetailVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 5..
//

import UIKit

class ContentDetailVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //투두 - 타이틀이랑 데이트 여기 밖으로 빼내서 연결
    @IBOutlet weak var likeCountLbl: UILabel!
    
    @IBOutlet weak var commentCountLbl: UILabel!
    
    @IBOutlet weak var pageLbl: UILabel!
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    //backBtn
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var data = ContentData.sharedInstance.contentDetails
//-------------------collectionView-------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    // let detail2 = ContentSample(images: [#imageLiteral(resourceName: "inni"),#imageLiteral(resourceName: "dabi"),#imageLiteral(resourceName: "inni"),#imageLiteral(resourceName: "dabi")], title: "dk", date: "9090.90.90", category: "스토리", imageCount: "1/20")
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentDetailCell.reuseIdentifier, for: indexPath) as! ContentDetailCell
        cell.configure(index : indexPath.row, data: data[0])
        cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            pageLbl.isHidden = true
            
            return
        }else {
            //cell밖으로 빼내야하나~?~?~?~?
            pageLbl.isHidden = false
            pageLbl.text = "\(indexPath.row)"
        }
        
        //투두 - 연결해논것 indexPath.row > 0 이면 날짜랑, 타이틀 레이블.isHidden = true 로 주기
        
    }


    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0,0,0,0)
    }
    //cellsize
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width , height: 527)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
