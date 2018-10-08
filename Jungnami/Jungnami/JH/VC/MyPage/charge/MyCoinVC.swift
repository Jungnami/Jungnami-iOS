//
//  MyCoinVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 9..
//

import UIKit

class MyCoinVC: UIViewController,APIService {

    //가격버튼 누르면 alert 띄우기
   
    
    @IBOutlet weak var myCoinLbl: UILabel!
    var myCoin = 0 {
        didSet {
            myCoinLbl.text = "\(myCoin)개"
        }
    }
    
    @IBAction func priceBtn(_ sender: Any) {
        simpleAlert(title: "알림", message: "결제서비스는 현재 사용할 수 없습니다")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMyCoin(url : UrlPath.GetCoin.getURL())
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

//통신

extension MyCoinVC {
    func getMyCoin(url : String){
        GetCoinService.shareInstance.getCoin(url: url, completion: { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .networkSuccess(let coinData):
                let data = coinData as! CoinVOData
                let myCoin = data.userCoin
                self.myCoin = myCoin
                break
            case .networkFail :
                self.simpleAlert(title: "오류", message: "네트워크 연결상태를 확인해주세요")
            default :
                break
            }
            
        })
    }
    
}
