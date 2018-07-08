//
//  LoginVC.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 8..
//

import UIKit

class LoginVC: UIViewController {

    var tabbarVC : UIViewController?
   
    
    @IBAction func withoutLogin(_ sender: Any) {
         self.tabbarVC = Storyboard.shared().mainStoryboard.instantiateViewController(withIdentifier: "tabBar") as! TabbarVC
        if let tabbarVC_ = tabbarVC {
             self.present(tabbarVC_, animated: true, completion: nil)
        }
       
        
    }
    @IBAction func loginWithKakao(_ sender: Any) {let session: KOSession = KOSession.shared();
        
        if session.isOpen() {
            session.close()
        }
        
        session.open(completionHandler: { (error) -> Void in
            loginWith = .kakao
            print("카카오톡 로그인!")
            
            if error == nil{
                print("no Error");
                if session.isOpen(){
                    print("token : \(session.token.accessToken)")
                    print("refresh token : \(session.token.refreshToken)")
                    
                    
                }else{
                    print("Login failed")
                }
            }else{
                print("Login error : \(error)")
            }
            // 사용자 정보 요청
            KOSessionTask.userMeTask { [weak self] (error, me) in
                if let error = error as NSError? {
                    self?.simpleAlert(title: "err", message: error.description)
                    
                } else if let me = me as KOUserMe? {
                    
                    
                    print(self?.gsno(me.id) ?? "id")
                    print(self?.gsno(me.nickname) ?? "nickname")
                    
                }
            }
            //이제 로그인 하면 네트워킹 해서 userData 보내줘야함
            if !session.isOpen() {
                if let error = error as NSError? {
                    switch error.code {
                    case Int(KOErrorCancelled.rawValue):
                        break
                    default:
                        self.simpleAlert(title: "err", message: error.description)
                    }
                }
            }
        })
    } //카카오톡 끝

    override func viewDidLoad() {
        super.viewDidLoad()

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
