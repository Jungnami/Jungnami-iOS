//////
//////  PartyListDetailPageMenuBar.swift
//////  Jungnami
//////
//////  Created by 강수진 on 2018. 7. 6..
//////
////
//import UIKit
//
//
//class MenuCell: BaseCell {
//    
//    let titleLbl: UILabel = {
//        let iv = UILabel()
//        iv.text = "정당"
//        iv.tintColor = .red
//        return iv
//    }()
//    
//
//    
//    override var isHighlighted: Bool {
//        didSet {
//            titleLbl.tintColor = isHighlighted ? UIColor.black : .red
//        }
//    }
//    
//    override var isSelected: Bool {
//        didSet {
//            titleLbl.tintColor = isSelected ? UIColor.black : .green
//        }
//    }
//    
//    override func setupViews() {
//        super.setupViews()
//        titleLbl.sizeToFit()
//        
//        addSubview(titleLbl)
//        
//        addConstraintsWithFormat("H:[v0(60)]", views: titleLbl)
//        addConstraintsWithFormat("V:[v0(60)]", views: titleLbl)
//        titleLbl.textAlignment = .center
//        titleLbl.font = UIFont.systemFont(ofSize: 14.0)
//        
//        
//        addConstraint(NSLayoutConstraint(item: titleLbl, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
//        addConstraint(NSLayoutConstraint(item: titleLbl, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
//    }
//    
//}
//
//class BaseCell: UICollectionViewCell {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupViews()
//    }
//    
//    func setupViews() {
//        
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//

