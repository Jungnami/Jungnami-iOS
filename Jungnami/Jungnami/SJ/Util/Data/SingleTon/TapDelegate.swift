//
//  TapDelegate.swift
//  Jungnami
//
//  Created by 강수진 on 2018. 7. 8..
//

import UIKit

protocol TapDelegate {
    func myTableDelegate(index : Int)
}


protocol TapDelegate2 {
    func myTableDelegate(sender : UITapGestureRecognizer)
}

protocol ReportDelegate {
    func report(index : Int)
}

extension ReportDelegate where Self : UIViewController{
    func report(index : Int){
        self.reportAction(reportId: index, reportHandler: { (reportReason) in
            //신고 url 넣기
            let relation = ReportCategory.content.rawValue
            let params : [String : Any] = [
                "relation" : relation,
                "relation_id" : index,
                "content" : reportReason
            ]
            
            self.reportAction(url: UrlPath.Report.getURL(), parmas: params)
        })
    }
    
    func reportAction(url : String, parmas : [String : Any]){
        ReportService.shareInstance.report(url: url, params: parmas, completion: {  [weak self] (result) in
            guard let `self` = self else { return }
            
            switch result {
            case .networkSuccess(_):
                self.noticeSuccess("신고 완료", autoClear: true, autoClearTime: 1)
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
