
//  Created by Harsh on 18/04/24.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet weak var tblView:UITableView!
    var viewModelUser = UserInfoModel()
    var userDetail = [Employees]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let langStr = Locale.current.languageCode
        let langStrCode = Locale.isoLanguageCodes
        
        // Do any additional setup after loading the view.
        let param = ["vendor_id":"2"]
        //ws_Get_Profile(url: "http://43.204.165.115:7077/api/user/getUserProfile?userId" + UserDefaults.st
        //andard.string(forKey: "userID")!, parameter: param)
        tblView.register(UINib(nibName: "UserrCell", bundle: nil), forCellReuseIdentifier: "UserrCell")
        //viewModelUser.getAllUsreDataAF()

        viewModelUser.ws_GetVendor(url: WLinks.ws_get_vendor_profile, parameter: param) {
            result in
            //self.userDetail = userData
            
            switch result{
            case .success(let userData):
                let dic = userData.data
                let token = dic.token
                
                print("Token is ->>>>>",token)
            case .failure(let error):
                print(error)
            }
            
//            let dataa = userData.dat
//            let userId = dataa.token
//            print("userId is ->>>>>>>>",userId)
//            let msgg = userData[0].msg
//            print("user message ->>>>>>>>",msgg!)

        }
        
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
