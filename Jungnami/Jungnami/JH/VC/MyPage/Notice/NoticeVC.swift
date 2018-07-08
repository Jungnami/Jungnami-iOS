//
//  NoticeVC.swift
//  Jungnami
//
//  Created by 이지현 on 2018. 7. 7..
//

import UIKit

class NoticeVC: UIViewController{
    
    var keyboardDismissGesture: UITapGestureRecognizer?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.dataSource = self
//        tableView.delegate = self
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    //cell.delegate = self
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //다시!!!!!!!!!!!!!!!!!!!!!1
//
//    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentCell
//        cell.recommentBtn.isUserInteractionEnabled = true
//        return cell
//    }
    
}
