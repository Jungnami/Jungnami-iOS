//
//  CommunityWriteVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 2..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class CommunityWriteVC: UIViewController, UITextViewDelegate, APIService {
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        contentTxtView.text = "생각을 공유해 보세요"
        contentTxtView.textColor = UIColor.lightGray
        doneBtn.setImage(#imageLiteral(resourceName: "writepage_complete_gray_button"), for: .normal)
        doneBtn.isUserInteractionEnabled = false
        removeImgView()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var contentTxtView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    var contentImgView: UIImageView = UIImageView()
    var imgURL : String? = ""
    var images : [String : Data]?
    var keyboardDismissGesture: UITapGestureRecognizer?
    var delegate : TapDelegate?
    let imagePicker : UIImagePickerController = UIImagePickerController()
    lazy var deleteImgBtn : UIButton = {
        let button = UIButton()
        button.isEnabled = true
        button.isUserInteractionEnabled = true
        button.setImage(#imageLiteral(resourceName: "writepage_x"), for: .normal)
        button.addTarget(self, action: #selector(CommunityWriteVC.deleteImg(_sender:)), for: .touchUpInside)
        return button
    }()
    
    var imageData : Data? {
        didSet {
            if imageData != nil {
                if let imageData_ = imageData {
                    makeImgView()
                    contentImgView.image =  UIImage(data: imageData_)
                    doneBtn.setImage(#imageLiteral(resourceName: "writepage_complete_blue_button"), for: .normal)
                    doneBtn.isUserInteractionEnabled = true
                    
                }
            }
 
        }
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardSetting()
        setToolbar()
        contentTxtView.delegate = self
        doneBtn.addTarget(self, action: #selector(doneOk), for: .touchUpInside)
        if let url = URL(string: gsno(imgURL)){
            self.profileImgView.kf.setImage(with: url)
        } else {
            self.profileImgView.image = #imageLiteral(resourceName: "mypage_profile_girl")
        }
        profileImgView.makeImageRound()
    }
    
    @objc func clickGif(){
        
    }
    @objc func clickImg(){
        openGallery()
    }
    @objc public func deleteImg (_sender: UIButton) {
        removeImgView()
    }
    
    @objc func doneOk(){
        //통신
        writeContent(url : UrlPath.Board.getURL())
    }
    
}

//이미지뷰에 대한 추가 및 삭제
extension CommunityWriteVC {
    func makeImgView(){
        self.view.addSubview(contentImgView)
        self.view.addSubview(deleteImgBtn)
        deleteImgBtn.contentMode = .scaleAspectFit
        contentImgView.snp.makeConstraints { (make) in
            make.height.equalTo(302)
            make.top.equalTo(contentTxtView.snp.bottom).offset(22.5)
            make.leading.trailing.equalTo(contentTxtView)
            
        }
        
        deleteImgBtn.snp.makeConstraints { (make) in
            make.height.equalTo(17)
            make.width.equalTo(17)
            make.leading.equalTo(contentImgView.snp.leading).offset(16)
            make.top.equalTo(contentImgView.snp.top).offset(16)
        }
    }
    
    func removeImgView(){
        self.imageData = nil
        self.contentImgView.removeFromSuperview()
        self.deleteImgBtn.removeFromSuperview()
    }
    
}

//custom toolbar
extension CommunityWriteVC {
    func setToolbar(){
        let toolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolbar.barStyle = .default
        let pictureImg = UIImage(named: "writepage_picture")?.withRenderingMode(.alwaysOriginal)
        let gifImg = UIImage(named: "writepage_gif")?.withRenderingMode(.alwaysOriginal)
        let pictureBtn = UIBarButtonItem(image: pictureImg, style: .plain, target: self, action: #selector(clickImg))
        let gifBtn = UIBarButtonItem(image: gifImg, style: .plain, target: self, action: #selector(clickGif))
        let fixedSpace = UIBarButtonItem(
            barButtonSystemItem: UIBarButtonSystemItem.fixedSpace,
            target: nil,
            action: nil
        )
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        fixedSpace.width = 20
        
       // toolbar.items = [pictureBtn, fixedSpace, gifBtn, flexibleSpace]
        toolbar.items = [pictureBtn, flexibleSpace]
        toolbar.barTintColor = .white
        toolbar.sizeToFit()
        contentTxtView.inputAccessoryView = toolbar
    }
}

//TextView delegate
extension CommunityWriteVC {
    
    //텍스트뷰 플레이스 홀더처럼
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "생각을 공유해 보세요"
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        //TODO - 스페이스만 입력 됐을 때 처리
        
        
        if let myString = textView.text {
            let emptySpacesCount = myString.components(separatedBy: " ").count-1
            if emptySpacesCount == myString.count {
                doneBtn.setImage(#imageLiteral(resourceName: "writepage_complete_gray_button"), for: .normal)
                doneBtn.isUserInteractionEnabled = false
                return
            }
            
            let nCount = myString.components(separatedBy: "\n").count-1
            if nCount == myString.count {
                doneBtn.setImage(#imageLiteral(resourceName: "writepage_complete_gray_button"), for: .normal)
                doneBtn.isUserInteractionEnabled = false
                return
            }
            
            let nCount_emptySpaceCount = nCount+emptySpacesCount
            if nCount_emptySpaceCount == myString.count {
                doneBtn.setImage(#imageLiteral(resourceName: "writepage_complete_gray_button"), for: .normal)
                doneBtn.isUserInteractionEnabled = false
                return
            }
        }
        
        if contentTxtView.text?.count == 0 {
            doneBtn.setImage(#imageLiteral(resourceName: "writepage_complete_gray_button"), for: .normal)
            doneBtn.isUserInteractionEnabled = false
        } else if ((contentTxtView.text?.count)! < 150){
            doneBtn.setImage(#imageLiteral(resourceName: "writepage_complete_blue_button"), for: .normal)
            doneBtn.isUserInteractionEnabled = true
            
        } else {
            guard let contentTxt = contentTxtView.text else {return}
            simpleAlert(title: "오류", message: "150글자 초과")
            contentTxtView.text = String(describing: contentTxt.prefix(149))
            doneBtn.setImage(#imageLiteral(resourceName: "writepage_complete_blue_button"), for: .normal)
            doneBtn.isUserInteractionEnabled = true
        }
    }
    
}


//키보드 대응
extension CommunityWriteVC {
    func setKeyboardSetting() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: true)
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardEndframe = self.view.convert(keyboardSize, from: nil)
            
            var contentInset:UIEdgeInsets = self.scrollView.contentInset
            // contentInset.bottom = keyboardEndframe.size.height
            
            contentInset.bottom = 170
            scrollView.contentInset = contentInset
            self.scrollView.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        self.view.layoutIfNeeded()
    }
    
    func adjustKeyboardDismissGesture(isKeyboardVisible: Bool) {
        if isKeyboardVisible {
            if keyboardDismissGesture == nil {
                keyboardDismissGesture = UITapGestureRecognizer(target: self, action: #selector(tapBackground))
                view.addGestureRecognizer(keyboardDismissGesture!)
            }
        } else {
            if keyboardDismissGesture != nil {
                view.removeGestureRecognizer(keyboardDismissGesture!)
                keyboardDismissGesture = nil
            }
        }
    }
    
    @objc func tapBackground() {
        self.view.endEditing(true)
    }
}


//앨범 열기 위함
extension CommunityWriteVC : UIImagePickerControllerDelegate,
UINavigationControllerDelegate  {
    
    
    // Method
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.delegate = self
            //false 로 되어있으면 이미지 자르지 않고 오리지널로 들어감
            //이거 true로 하면 crop 가능
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    // imagePickerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //사용자 취소
        self.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //크롭한 이미지
        if let editedImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageData = UIImageJPEGRepresentation(editedImage, 0.1)
        } else if let originalImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageData = UIImageJPEGRepresentation(originalImage, 0.1)
        }
        
        self.dismiss(animated: true)
    }
}

//통신
extension CommunityWriteVC {
    func writeContent(url : String){
        var tempString = ""
        if contentTxtView.text == "생각을 공유해 보세요"{
            tempString = ""
        } else {
            tempString = contentTxtView.text
        }
        
        let params : [String : Any] = [
            "shared" : 0,
            "content" : tempString
        ]
        
        if let image = imageData {
            images = [
                "image" : image
            ]
        }
        
        CommunityWriteCompleteService.shareInstance.registerBoard(url: url, params: params, image: images, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(_):
                self.delegate?.myTableDelegate(index: -1)
                self.dismiss(animated: true, completion: nil)
            case .networkFail :
                self.simpleAlert(title: "오류", message: "인터넷 연결상태를 확인해주세요")
            default :
                break
            }
        })
        

    }
}


