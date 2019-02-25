//
//  MoyaVC.swift
//  Jungnami
//
//  Created by 강수진 on 21/02/2019.
//

import UIKit

class MoyaVC: UIViewController {
    var networkProvider = NetworkManager.sharedInstance

    @IBOutlet weak var textview: UITextView!
    @IBAction func clickParty(_ sender: Any) {
        
        //댓글 평가(좋아요 싫어요)
        networkProvider.evaluateComment(isAboutLegislator: true, isLike: true, commentIdx: 10) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .Success(let successMsg):
                self.simpleAlert(title: "성공", message: successMsg)
            case .Failure(let errorType) :
                self.showErrorAlert(errorType: errorType)
            }
        }
        
        //국회의원 댓글 수정
        /*networkProvider.changeComment(isAboutLegislator: true, commentIdx: 11, writerIdx: 4, content: "wanna go home~") { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .Success(let successMsg):
                self.simpleAlert(title: "성공", message: successMsg)
            case .Failure(let errorType) :
                self.showErrorAlert(errorType: errorType)
            }
        }*/
        //국회의원 댓글 삭제
        /*networkProvider.deleteComment(isAboutLegislator: true, commentIdx: 16, writerIdx: 4) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .Success(let successMsg):
                self.simpleAlert(title: "성공", message: successMsg)
            case .Failure(let errorType) :
                self.showErrorAlert(errorType: errorType)
            }
        }*/
        //국회의원 댓글 달기
        /*networkProvider.writeComment(isAboutLegislator: true, legiIdx: 100014, content: "hihi") { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .Success(let successMsg):
                self.textview.text = successMsg
            case .Failure(let errorType) :
                self.showErrorAlert(errorType: errorType)
            }
        }*/
        //국회의원 댓글 조회
        /*networkProvider.getCommentList(isAboutLegislator: true, idx: 100014) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .Success(let legislatorCommentList):
                
                func getDate(date : String) -> String {
                    let dateFormatterGet = DateFormatter()
                    dateFormatterGet.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSSXXX"
                    
                    let dateFormatterPrint = DateFormatter()
                    dateFormatterPrint.dateFormat = "MMM dd,yyyy"
                    
                    if let date = dateFormatterGet.date(from: date) {
                        return dateFormatterPrint.string(from: date)
                    } else {
                        print("There was an error decoding the string")
                        return ""
                    }
                }
                
                self.textview.text = getDate(date: legislatorCommentList.first?.writetime ?? "")
                
            case .Failure(let errorType) :
                self.showErrorAlert(errorType: errorType)
            }
        }*/
        
        //국회의원 디테일
        /*networkProvider.getLegislatorDetail(idx: 100235) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .Success(let legislatorDetail):
                self.textview.text = legislatorDetail.legiName
            case .Failure(let errorType) :
                self.showErrorAlert(errorType: errorType)
            }
        }*/
 
        //투표권수 확인
        /*networkProvider.checkBallot { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .Success(let voteCount):
                self.simpleAlert(title: "성공", message: voteCount.description)
            case .Failure(let errorType) :
                self.showErrorAlert(errorType: errorType)
            }
        }*/
        
        //의원 투표
        networkProvider.vote(legiCode: 100014, isLike: true) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .Success(let voteMsg):
                self.simpleAlert(title: "성공", message: voteMsg)
            case .Failure(let errorType) :
                self.showErrorAlert(errorType: errorType)
            }
        }
        //전체 의원
        /*networkProvider.getAllLegislatorList(isLike: true) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .Success(let legislatorListInfo):
                guard let firstLegi = legislatorListInfo.data.first else {return}
                let partyName = firstLegi.partyCD.partyName
                let partyColor = firstLegi.partyCD.partyColor
                let textContent = firstLegi.legiName+partyName+legislatorListInfo.timeStamp
                self.textview.textColor = partyColor
                self.textview.text = textContent
                
            case .Failure(let errorType) :
                self.showErrorAlert(errorType: errorType)
            }
        }*/
        
        //시티별 의원
       /* networkProvider.getCityLegislatorList(isLike: true, city: .seoul) { [weak self] (result) in
            guard let `self` = self else { return }
            switch result {
            case .Success(let legislatorList):
                guard let firstLegi = legislatorList.first else {return}
                let partyName = firstLegi.partyCD?.partyName
                let partyColor = firstLegi.partyCD?.partyColor
                let textContent = firstLegi.legiName+firstLegi.region
                self.textview.textColor = partyColor
                self.textview.text = textContent
                
            case .Failure(let errorType) :
                self.showErrorAlert(errorType: errorType)
            }
        }*/
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
