//
//  ContentDetailVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 5..
//

import UIKit

class ContentDetailVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    

    @IBOutlet weak var detailCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        // Do any additional setup after loading the view.
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
         cell.configure(index: indexPath.row, data: data[0])
    //     cell.contentDetailTitleLbl.text = "hihi"
        cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0,0,0,0)
    }
   
}
