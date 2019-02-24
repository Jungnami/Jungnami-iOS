//
//  LoginVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 8..
//

import UIKit

class LoginVC: UIViewController, APIService{
    
    //0이면 처음 들어오는것 1이면 중간에 들어오는것
    var entryPoint : Int = 0
    var tabbarVC : UIViewController?
    let userDefault = UserDefaults.standard
    var userData : LoginVOData?
    var accessToken : String?
    var userToken = ""
    @IBOutlet weak var dismissBtn: UIButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBAction func dismissClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func withoutLogin(_ sender: Any) {
        toMainPage()
    }
    
    
    @IBAction func loginWithKakao(_ sender: Any) {
       
        
        let session: KOSession = KOSession.shared();
        
        if session.isOpen() {
            session.close()
        }
        
        session.open(completionHandler: { (error) -> Void in
            loginWith = .kakao
            print("카카오톡 로그인!")
            
            if error == nil{
                print("no Error");
                if session.isOpen(){
                  //  print("token : \(session.token.accessToken)")
                  //  print("refresh token : \(session.token.refreshToken)")
                    let params : [String : Any] = ["accessToken" : session.token.accessToken,
                                                   "fcmToken" : UserDefaults.standard.string(forKey: "fcmToken") ?? "-1"]
                    
                    self.login(url: UrlPath.KakaoLogin.getURL(), params: params)
                   
                 
                }else{
                    print("Login failed")
                }
            }else{
                print("Login error : \(String(describing: error))")
            }
            if !session.isOpen() {
                if let error = error as NSError? {
                    switch error.code {
                    case Int(KOErrorCancelled.rawValue):
                        break
                    default:
                        //간편 로그인 취소
                        print("error : \(error.description)")
                        
                    }
                }
            }
        })
 
    } //카카오톡 끝
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //아예처음으로 들어옴
        if entryPoint == 0 {
            self.dismissBtn.isHidden = true
        } else {
            //중간에 들어옴
            self.dismissBtn.isHidden = false
            self.nextBtn.isHidden = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//통신
extension LoginVC {
    
    func login(url : String, params : [String:Any]){
        LoginService.shareInstance.login(url: url, params : params, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(let loginData):
                //유저 값 설정
                self.userData = loginData as? LoginVOData
                self.userDefault.set(self.userData?.id, forKey: "userIdx")
                self.userDefault.set(self.userData?.token, forKey : "userToken")
                //유저디폴트
                self.userToken = UserDefaults.standard.string(forKey: "userToken") ?? "-1"
               // print(self.userToken)
            case .accessDenied :
                self.simpleAlert(title: "오류", message: "Access Denied")
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
    } //login
    
    //메인페이지로
    func toMainPage(){
        if entryPoint == 0 {
            self.tabbarVC = Storyboard.shared().mainStoryboard.instantiateViewController(withIdentifier: "tabBar")
            if let tabbarVC_ = tabbarVC {
                self.present(tabbarVC_, animated: true, completion: nil)
            }
        } else {
            self.dismiss(animated: true, completion: nil)
        }
       
    }
}
