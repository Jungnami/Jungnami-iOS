//
//  NoticeVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 7..
//

import UIKit

class NoticeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   //-------------tapGesture-------------------------
    var keyboardDismissGesture: UITapGestureRecognizer?
    //-------------------------------------------------
    @IBOutlet weak var noticeTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(a.noticeType.returnType(userNickName: "수진"))
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        noticeTableView.delegate = self
        noticeTableView.dataSource = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    var notices = NoticeData.sharedInstance.notices
    //--------------tableView-------------
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notices.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoticeCell.reuseIdentifier, for: indexPath) as! NoticeCell
        //어떻게 뽑는지 모르게따 ㅜㅡㅜ
//        cell.configure(data: notices[indexPath.row].noticeType.returnType(userNickName: notices[indexPath.row]))
        cell.noticeProfileImgView.image = notices[indexPath.row].profileImg
        cell.noticeUserLbl.text = notices[indexPath.row].userNickname
        cell.noticeTypeLbl.text = notices[indexPath.row].noticeType.rawValue
        //tapGesture--------------
        cell.delegate = self
        //--------------------------
        return cell
    }
    
}
//-----------tapGesture---------------------------------------
extension NoticeVC : TapDelegate, UIGestureRecognizerDelegate {
    func myTableDelegate(index: Int) {
        print(index)
    }
}
