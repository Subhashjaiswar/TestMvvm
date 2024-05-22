//
//  FavraiteVC.swift
//  TestMvvm
//
//  Created by Harsh on 09/05/24.
//

import UIKit

class FavraiteVC: UIViewController {
    @IBOutlet weak var tblFav:UITableView!
    var favModel = FavraiteListModel()
    var arrFavv = [FavraiteData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let param = ["user_id":"2"]
        favModel.ws_GetFavraiteList(url: "https://logicaltest.website/Anju/Boricua/Api/get_favourite_list", parameter: param) { result in
            switch result{
            case .success(let favdata):
                let arr = favdata.data
                let messagess = favdata.msg
                self.toastMessage(messagess!)
                self.arrFavv = arr
                print("favraite list ->>>>>>",arr)
                print("hello")
                self.tblFav.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        favModel.vcc = self
    }

}

extension FavraiteVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFavv.count
        //return favModel.arrFav.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let dic = arrFavv[indexPath.row]
        //let dic = favModel.arrFav[indexPath.row]
        let cell = tblFav.dequeueReusableCell(withIdentifier: "FavCell") as! FavCell
        cell.lblName.text = dic.business_name
        //cell.favModell = dic
        //cell.dataConfigure()
        return cell
    }
  
}

