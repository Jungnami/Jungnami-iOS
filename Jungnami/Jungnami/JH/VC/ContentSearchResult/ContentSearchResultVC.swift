//
//  ContentSearchResultVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 13..
//

import UIKit

class ContentSearchResultVC: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}
