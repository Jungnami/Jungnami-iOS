//
//  ContentSearchResultVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 13..
//

import UIKit

class ContentSearchResultVC: UIViewController {
    
    

    @IBOutlet weak var contentSearchResultCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        contentSearchResultCollectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//extension ContentSearchResultVC: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//
//
//}
