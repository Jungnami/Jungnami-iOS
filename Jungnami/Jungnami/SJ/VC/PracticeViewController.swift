//
//  PracticeViewController.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 3..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit
import SnapKit

class PracticeViewController: UIViewController {

    
    
    lazy var navSearchView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var searchGrayView : UIImageView = {
        let imgView = UIImageView()
        
        imgView.image = #imageLiteral(resourceName: "community_search_field").withRenderingMode(.alwaysOriginal)
        return imgView
    }()
    
    
    lazy var searchTxtField : UITextField = {
        let txtField = UITextField()
        txtField.placeholder = "찾고 싶은 국회의원을 검색해보세요"
        txtField.font = UIFont.systemFont(ofSize: 14.0)
        return txtField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(navSearchView)
        navSearchView.snp.makeConstraints { (make) in
        
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            make.width.equalTo(316)
            make.height.equalTo(31)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide)
        }
        self.navSearchView.addSubview(searchGrayView)
        self.navSearchView.addSubview(searchTxtField)

        searchGrayView.snp.makeConstraints { (make) in
            make.top.leading.bottom.trailing.equalTo(navSearchView)
        }
        
        searchTxtField.snp.makeConstraints { (make) in
        make.top.bottom.trailing.equalTo(searchGrayView)
          make.leading.equalTo(searchGrayView).offset(30)
        }
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
