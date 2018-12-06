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
    @IBOutlet weak var warningBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var scarpBtn: UIButton!
    var contentIdx : Int? // contentDetail
    var contentImages: [ContentDetailVODataImgArr]?
    var contentTitle : String?
    var text : String?
    var thumnail : String?
    
    var isLike = 0 {
        didSet {
            if isLike == 0 {
                likeBtn.isSelected = false
            } else {
                 likeBtn.isSelected = true
            }
        }
    }
    
    var isScrap = 0 {
        didSet {
            if isScrap == 0 {
                scarpBtn.isSelected = false
            } else {
                scarpBtn.isSelected = true
            }
        }
    }
    var likeCount = 0
    //commentBtn
    @IBAction func commentBtn(_ sender: Any) {
        let communityStoartyboard = Storyboard.shared().communityStoryboard
        if let selectedContentId_ = self.contentIdx {
            if let commentVC = communityStoartyboard.instantiateViewController(withIdentifier:ContentCommentVC.reuseIdentifier) as? ContentCommentVC {
               
                commentVC.selectedContent = selectedContentId_
                //  commentVC.heartCount = sender.likeCnt
                //  commentVC.commentCount = sender.commentCnt
                
                self.present(commentVC, animated: true)
            }
        }
        
        
    }
    
    
    
    //shareBtn
    @IBAction func shareBtn(_ sender: Any) {
        //공유
    }
    
    
    
    //backBtn
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let contentIdx_ = contentIdx {
        contentDetailInit(url:UrlPath.ContentDetail.getURL(contentIdx_.description))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        self.tabBarController?.tabBar.isHidden = true
        //통신
        if let contentIdx_ = contentIdx {
            contentDetailInit(url: UrlPath.ContentDetail.getURL(contentIdx_.description))
        }
        likeBtn.addTarget(self, action: #selector(like(_:)), for: .touchUpInside)
        likeBtn.setImage(UIImage(named: "content_heart"), for: .normal)
        likeBtn.setImage(UIImage(named: "community_heart_blue"), for: .selected)
        scarpBtn.addTarget(self, action: #selector(scrap(_:)), for: .touchUpInside)
        scarpBtn.setImage(UIImage(named: "content_scrap"), for: .normal)
        scarpBtn.setImage(UIImage(named: "content_scrap_blue"), for: .selected)
        
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
            return contentDetails_.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentDetailCell.reuseIdentifier, for: indexPath) as! ContentDetailCell
        if let contentDetails_ = contentImages, let title_ = contentTitle , let text_ = text, let thumnail_ = thumnail{
            if indexPath.row == 0 {
                print("서브타이틀 확인")
                print(title_)
                cell.configure(title : title_, text : text_, thumnail : contentDetails_[0].imgURL)
            } else {
                cell.configure2(data: contentDetails_[indexPath.row])
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


extension ContentDetailVC {
    @objc func like(_ sender : UIButton){
        if isLike == 0 {
            likeAction(url: UrlPath.LikeContent.getURL())
        } else {
            dislikeAction(url: UrlPath.LikeContent.getURL(contentIdx!.description))
        }
    }
    
    @objc func scrap(_ sender : UIButton){
        if isScrap == 0 {
            scrapAction(url: UrlPath.ScrapContent.getURL())
        } else {
            scrapCancelAction(url: UrlPath.ScrapContent.getURL(contentIdx!.description))
        }
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
                if contentDetail.youtube != "0" {
                    
                    UIApplication.shared.open(URL(string : "https://youtu.be/\(contentDetail.youtube)")! as URL, options: [:], completionHandler: { (_) in
                        self.dismiss(animated: true)
                        self.navigationController?.popViewController(animated: true)
                        
                    })
                    
                } else {
                    self.likeCountLbl.text = "\(contentDetail.likeCnt)명"
                    self.likeCount = contentDetail.likeCnt
                    //이미지 어레이 가져오는거//
                    self.commentCountLbl.text = String(contentDetail.commentCnt)
                    self.contentImages = contentDetail.imagearray
                    self.contentTitle = contentDetail.title
                    self.text = contentDetail.text
                    self.thumnail = contentDetail.thumbnail
                    self.isLike = contentDetail.islike
                    self.isScrap = contentDetail.isscrap
                    self.detailCollectionView.reloadData()
                    
                }
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
    
    
    //하트 버튼 눌렀을 때
    func likeAction(url : String){
        let params : [String : Any] = [
            "contents_id" : contentIdx!
        ]

        CommunityLikeService.shareInstance.like(url: url, params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                self.isLike = 1

                
                var changed : Int = 0
                
                //Now change the text and background colour
                if self.likeCountLbl.text! == "\(self.likeCount)명" {
                   
                    changed = self.likeCount+1
                } else {
                
                    changed = self.likeCount
                }
                self.likeCountLbl.text = "\(changed)명"
                
                break
            case .accessDenied :
                self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
                    if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
                        loginVC.entryPoint = 1
                        self.present(loginVC, animated: true, completion: nil)
                    }
                })
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
    }
    
    //좋아요 취소
    func dislikeAction(url : String){
        CommunityDislikeService.shareInstance.dislikeCommunity(url: url, completion: {  [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                self.isLike = 0
                var changed : Int = 0

                //Now change the text and background colour
                if self.likeCountLbl.text! == "\(self.likeCount)명" {
                    changed = self.likeCount-1
                } else {
                    changed = self.likeCount
                }
                self.likeCountLbl.text = "\(changed)명"

                break
            case .accessDenied :
                self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
                    if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
                        loginVC.entryPoint = 1
                        self.present(loginVC, animated: true, completion: nil)
                    }
                })
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
    }
    
    
    
    
    
    //스크랩 눌렀을 때
    func scrapAction(url : String){
        
        let params : [String : Any] = [
            "contentsid" : contentIdx!
        ]
        CommunityLikeService.shareInstance.like(url: url, params: params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
            
                self.isScrap = 1
                
                
                break
            case .accessDenied :
                self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
                    if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
                        loginVC.entryPoint = 1
                        self.present(loginVC, animated: true, completion: nil)
                    }
                })
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
    }
    
    //스크랩 취소
    func scrapCancelAction(url : String){
        CommunityDislikeService.shareInstance.dislikeCommunity(url: url, completion: {  [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                 self.isScrap = 0
                
                
                break
            case .accessDenied :
                self.simpleAlertwithHandler(title: "오류", message: "로그인 해주세요", okHandler: { (_) in
                    if let loginVC = Storyboard.shared().rankStoryboard.instantiateViewController(withIdentifier:LoginVC.reuseIdentifier) as? LoginVC {
                        loginVC.entryPoint = 1
                        self.present(loginVC, animated: true, completion: nil)
                    }
                })
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
    }
    
  
}



