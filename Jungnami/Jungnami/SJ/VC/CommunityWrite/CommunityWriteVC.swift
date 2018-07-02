//
//  CommunityWriteVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 2..
//  Copyright © 2018년 강수진. All rights reserved.
//

import UIKit

class CommunityWriteVC: UIViewController, UITextViewDelegate {
    
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var contentTxtView: UITextView!

    var imageData : Data? = nil
    var keyboardDismissGesture: UITapGestureRecognizer?
    let imagePicker : UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeyboardSetting()
        setToolbar()
        profileImgView.makeImageRound()
        contentTxtView.text = "생각을 공유해 보세요"
        contentTxtView.textColor = UIColor.lightGray
        self.contentTxtView.delegate = self
    }
    
    @objc func clickGif(){
    
    }
    @objc func clickImg(){
        openGallery()
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
        
        toolbar.items = [pictureBtn, fixedSpace, gifBtn, flexibleSpace]
        toolbar.barTintColor = .white
        toolbar.sizeToFit()
        contentTxtView.inputAccessoryView = toolbar
    }
}

//TF delegate
extension CommunityWriteVC {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
    
    //TODO - 스페이스만 입력 됐을 때 처리
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 0 {
            doneBtn.setImage(#imageLiteral(resourceName: "writepage_complete_blue_button"), for: .normal)
            doneBtn.isUserInteractionEnabled = true
        } else {
            doneBtn.setImage(#imageLiteral(resourceName: "writepage_complete_gray_button"), for: .normal)
            doneBtn.isUserInteractionEnabled = false
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
           
            let keyboardEndframe = self.view.convert(keyboardSize, to : view.window)
            contentTxtView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardEndframe.height, right: 0)
            contentTxtView.scrollIndicatorInsets = contentTxtView.contentInset

            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        adjustKeyboardDismissGesture(isKeyboardVisible: false)
            contentTxtView.contentInset = UIEdgeInsets.zero
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
extension CommunityWriteVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Method
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.delegate = self
            //false 로 되어있으면 이미지 자르지 않고 오리지널로 들어감
            //이거 true로 하면 crop 가능
            self.imagePicker.allowsEditing = true
            self.present(self.imagePicker, animated: true, completion: { print("이미지 피커 나옴") })
        }
    }
    
    // imagePickerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("사용자가 취소함")
        self.dismiss(animated: true) {
            print("이미지 피커 사라짐")
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    
        //크롭한 이미지
        if let editedImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageData = UIImageJPEGRepresentation(editedImage, 0.1)
        } else if let originalImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
           imageData = UIImageJPEGRepresentation(originalImage, 0.1)
        }
        
        self.dismiss(animated: true) {
            print("이미지 피커 사라짐")
        }
    }
}


