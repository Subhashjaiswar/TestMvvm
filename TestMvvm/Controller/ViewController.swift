//
//  ViewController.swift
//  TestMvvm
//
//  Created by Harsh on 18/04/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tblView:UITableView!
    var viewModelUser = UserInfoModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tblView.register(UINib(nibName: "UserrCell", bundle: nil), forCellReuseIdentifier: "UserrCell")
        viewModelUser.getAllUsreDataAF()
        viewModelUser.vc = self
    }

}

extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelUser.arrUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "UserrCell", for: indexPath) as! UserrCell
        
        let userData = viewModelUser.arrUser[indexPath.row]
//        cell.lblId.text = "\(userData.userId!)"
//        cell.lblTitle.text = "\(userData.title!)"
//        cell.lblbody.text = "\(userData.completed!)"
//        let status = userData.getStatusColor()
//        cell.lblbody.text = status.0
//        cell.backgroundColor = status.1
        cell.userModl = userData
        cell.userConfigure()
        return cell
    }
    
    
}
