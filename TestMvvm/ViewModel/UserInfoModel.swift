//
//  UserInfo.swift
//  TestMvvm
//
//  Created by Harsh on 18/04/24.
//

import UIKit
import Alamofire

class UserInfoModel{
    
    weak var vc: ViewController?
    var arrUser = [UserInfo]()
    
    func getAllUsreDataAF(){
        AF.request("https://jsonplaceholder.typicode.com/todos/").response { response in
            if let data = response.data {
                do{
                    let userResponse = try JSONDecoder().decode([UserInfo].self, from: data)
                    self.arrUser.append(contentsOf: userResponse)
                    DispatchQueue.main.async{
                        self.vc?.tblView.reloadData()
                    }
                }catch let err{
                    print(err.localizedDescription)
                }
            }
        }
    }
    
    func getUserData(){
        URLSession.shared.dataTask(with: URL(string: "https://jsonplaceholder.typicode.com/todos/")!) { (data, response, error) in
            if error == nil{
                if let data = data {
                    do{
                        let userResponse = try JSONDecoder().decode([UserInfo].self, from: data)
                        self.arrUser.append(contentsOf: userResponse)
                        DispatchQueue.main.async{
                            self.vc?.tblView.reloadData()
                        }
                    }catch let err{
                        print(err.localizedDescription)
                    }
                }
            }else{
                print(error?.localizedDescription)
            }
        }.resume()
    }
    
    
}
