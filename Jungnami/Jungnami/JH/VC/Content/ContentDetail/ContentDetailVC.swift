//
//  ContentDetailVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 5..
//

import UIKit

class ContentDetailVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var data = ContentData.sharedInstance.contentDetails
//-------------------collectionView-------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentDetailCell.reuseIdentifier, for: indexPath) as! ContentDetailCell
        
        return cell
    }
   
}
