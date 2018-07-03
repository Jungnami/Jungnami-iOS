//
//  ContentVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 2..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class ContentVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var menuBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        addNavBarImage()
        

    }
    
    
    func addNavBarImage() {
        
        let navController = navigationController!
        
        let image = UIImage(named: "content_search_field") //Your logo url here
        let imageView = UIImageView(image: image)
        
//        let bannerWidth = navController.navigationBar.frame.size.width
//        let bannerHeight = navController.navigationBar.frame.size.height
        
//        let bannerX = bannerWidth / 2 - (image?.size.width)! / 2
//        let bannerY = bannerHeight / 2 - (image?.size.height)! / 2
        
        imageView.frame = CGRect(x: 0, y: 0, width: 279, height: 31)
        imageView.contentMode = .scaleAspectFit
        
        navigationItem.titleView = imageView
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //collectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            //TODO - 데이터 받아 올 때 그 숫자에 맞춰야 함
           return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
        let cell = UIStoryboard(name: "Sub", bundle: nil).instantiateViewController(withIdentifier: "ContentFirstCell") as! ContentFirstCell
            //cell에 데이터 연결!
            
            return cell
        }else {
            let cell = UIStoryboard(name: "Sub", bundle: nil).instantiateViewController(withIdentifier: "ContentSecondCell") as! ContentSecondCell
            //cell에 데이터 연결!
            
            return cell
        }
    }


}
