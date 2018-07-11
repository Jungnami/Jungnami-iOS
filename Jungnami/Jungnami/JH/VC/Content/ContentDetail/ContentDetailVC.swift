//
//  ContentDetailVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 5..
//

import UIKit

class ContentDetailVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, APIService {
    
    //투두 - 타이틀이랑 데이트 여기 밖으로 빼내서 연결
    @IBOutlet weak var likeCountLbl: UILabel!
    
    @IBOutlet weak var commentCountLbl: UILabel!
    
    @IBOutlet weak var pageLbl: UILabel!
    @IBOutlet weak var detailCollectionView: UICollectionView!
    
    
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    //likeBtn
    @IBAction func likeBtn(_ sender: Any) {
        //수진통신
    }
    //commentBtn
    @IBAction func commentBtn(_ sender: Any) {
        let chatVC = Storyboard.shared().communityStoryboard.instantiateViewController(withIdentifier: BoardDetailViewController.reuseIdentifier ) as! BoardDetailViewController
        self.present(chatVC, animated: true, completion: nil)
    }
    //shareBtn
    @IBAction func shareBtn(_ sender: Any) {
        //공유
    }
    //scrapBtn
    @IBAction func scrapBtn(_ sender: Any) {
        //수진!
    }
    
    
    //backBtn
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //통신
    var contentIdx : Int? // contentDetail
    var contentImages: [ContentDetailVODataImgArr]?
    var contentTitle : String?
    var writeTime : String?
    var thumnail : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        self.tabBarController?.tabBar.isHidden = true
        //통신
        if let contentIdx_ = contentIdx {
            contentDetailInit(url: url("/contents/cardnews/\(contentIdx_)"))
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //샘플 var data = ContentData.sharedInstance.contentDetails
    
    //-------------------collectionView-------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let contentDetails_ = contentImages {
            return contentDetails_.count+1
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentDetailCell.reuseIdentifier, for: indexPath) as! ContentDetailCell
        if let contentDetails_ = contentImages, let title_ = contentTitle , let writeTime_ = writeTime, let thumnail_ = thumnail{
            if indexPath.row == 0 {
                cell.configure(title : title_, writeTime : writeTime_, thumnail : thumnail_)
            } else {
                cell.configure2(data: contentDetails_[indexPath.row-1])
            }
            
        }
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
    
    
    
    //collectonviewLayout
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
//통신
extension ContentDetailVC {
    //extension에서 이름 바꾸고
    
    func contentDetailInit(url : String){ //contentTmiInit 이름 바꾸고 //viewdidload / viewwillappear에서 불러줘야함
        ContentDetailService.shareInstance.getContentDetail(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(let contentDetail):
                //likeCnt, commentCnt 여기서
                let contentDetail = contentDetail as!  ContentDetailVOData
                self.likeCountLbl.text = String(contentDetail.likeCnt)
                //이미지 어레이 가져오는거//
                self.commentCountLbl.text = String(contentDetail.commentCnt)
                self.contentImages = contentDetail.imagearray
                self.contentTitle = contentDetail.title
                self.writeTime = contentDetail.text
                self.thumnail = contentDetail.thumbnail
                self.detailCollectionView.reloadData()
                break
            case .nullValue :
                self.simpleAlert(title: "오류", message: "값 없음")
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
        
    }
}


