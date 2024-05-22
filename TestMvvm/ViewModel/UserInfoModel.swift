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
    var userData: Employees?
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
 
    
    func ws_GetVendor(url:String,parameter: Parameters,completion : @escaping (Result<Employees, Error>) -> ()){
         //Loader.showLoaderView()
        print(parameter)
        
        AF.request(url, method: .post, parameters: parameter, headers: APIManager.headers()).responseJSON { response in
               print(response)
           // Loader.hideLoaderView()
               switch response.result {
               case .success:
                   print(response)
                   if response.value == nil {
                       print("No response")
                       return
                   } else {
                  if let dd = response.value as? NSDictionary{
                   let res = dd["result"] as! String
                    if res == "true"{
                      switch response.result {
                        case .failure(let error):
                        print(error)
                          //completion(error)
                      case .success(_):
                        do {
                            
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let result = try decoder.decode(Employees.self, from: response.data!)
                            print("all data ->>>>>>",result)
                            //self.userData = result
                            self.userData = result
                            //completion(self.userData)
                            completion(.success(result))
                          
                            }catch
                              {
                                print(error)
                              }
                            }
                    }else{
                       
                    }
                 
             }
         
       }
                   
                  break
                  case .failure(let error):
                  print(error)
                 //Loader.hideLoaderView()
                
               }
           }

    }
    
}
 





