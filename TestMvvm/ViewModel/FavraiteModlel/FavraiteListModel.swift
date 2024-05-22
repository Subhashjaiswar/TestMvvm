//
//  FavraiteListModel.swift
//  TestMvvm
//
//  Created by Harsh on 09/05/24.
//

import Foundation
import Alamofire

class FavraiteListModel{
    weak var vcc: FavraiteVC?
    var arrFav = [FavraiteData]()
    
    
  /*  func ws_GetFavraiteList(url:String,parameter: Parameters,completion : @escaping (Result<FavraiteModel, Error>) -> ()){
         //Loader.showLoaderView()
        print(parameter)
        
        AF.request(url, method: .post, parameters: parameter, headers: APIManager.headers()).responseJSON { response in
              // print(response)
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
                            let result = try decoder.decode(FavraiteModel.self, from: response.data!)
                            print("all data ->>>>>>",[result])
                            
                            self.arrFav.append(contentsOf: result.data)
                        
                            //completion(.success(result))
                            
                            DispatchQueue.main.async {
                                self.vcc?.tblFav.reloadData()
                            }
                          
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
    */
    
    
    func ws_GetFavraiteList(url:String,parameter: Parameters,completion : @escaping (Result<FavraiteModel, Error>) -> ()){
         //Loader.showLoaderView()
        print(parameter)
        
        AF.request(url, method: .post, parameters: parameter, headers: APIManager.headers()).responseJSON { response in
              // print(response)
           // Loader.hideLoaderView()
            
              switch response.result {
                case .failure(let error):
                print(error)
                  //completion(error)
              case .success(_):
                do {
                    
                    if let dd = response.value as? NSDictionary{
                     let res = dd["result"] as! String
                      if res == "true"{
                          
                          let decoder = JSONDecoder()
                          decoder.keyDecodingStrategy = .convertFromSnakeCase
                          let result = try decoder.decode(FavraiteModel.self, from: response.data!)
                          print("all data ->>>>>>",[result])
                          completion(.success(result))
                          
                         //self.arrFav.append(contentsOf: result.data)
//                          DispatchQueue.main.async {
//                              self.vcc?.tblFav.reloadData()
//                          }
                          
                      }else{
                          
                      }
                    }
                   }catch
                      {
                        print(error)
                      }
                    }
           }

    }
    
}

/*
 
 func UploadProfile(){
 //vendor_id,listing_images[],owner_image,business_logo,menu[],vedio,optional(vedio_price)"}
        //let upload_url = "http://43.204.164.206:7077/video/updateVideoThumbNail"
        // let image = UIImage(named: "your_image_name")
     self.imgDataLogo = imgProfile.image!.jpegData(compressionQuality: 0.1)!
     
     let params = ["user_id":UserDefaults.standard.string(forKey: "userId")!,"first_name":self.lblFname.text!,"last_name":lblLname.text!]
     print(params)
       // imageData = self.thumb_img.jepg
       AF.upload(multipartFormData: { multiPart in
         
           multiPart.append(self.imgDataLogo, withName: "user_image", fileName: "image.jpg", mimeType: "image/jpeg")
           for (key, value) in params {

              multiPart.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
         }

       }, to: WLinks.ws_update_user_profile, method: .post, headers: APIManager.headers()) .uploadProgress(queue: .main, closure: { progress in
           print("Upload Progress: \(progress.fractionCompleted)")
           Loader.showLoaderView()
       }).responseJSON(completionHandler: { data in
           print("upload finished: \(data)")
       }).response { (response) in
           switch response.result {
           case .success(let resut):
               Loader.hideLoaderView()
               print("upload success result: \(resut)")
               self.navigationController?.popViewController(animated: true)
           case .failure(let err):
               print("upload err: \(err)")
           }
       }
 }
 */
