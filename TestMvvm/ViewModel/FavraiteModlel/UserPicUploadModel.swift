//
//  UserPicUploadModel.swift
//  TestMvvm
//
//  Created by Harsh on 09/05/24.
//

import Foundation
import Alamofire

class UserPicUploadModel{
    var imgDataLogo = Data()
    func UploadProfile(imgDataLogoo:Data,completion : @escaping (Result<UploadPicModel, Error>) -> ()){

         let params = ["user_id":"2","first_name":"Subhash","last_name":"Jaiswar"]
         print(params)
           // imageData = self.thumb_img.jepg
           AF.upload(multipartFormData: { multiPart in
               
               multiPart.append(imgDataLogoo, withName: "u1ser_image", fileName: "image.jpg", mimeType: "image/jpeg")
               for (key, value) in params {

                  multiPart.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
             }
               //"https://logicaltest.website/Anju/Boricua/Api/update_user_profile"
           }, to: WLinks.ws_update_user_profile, method: .post, headers: APIManager.headers()) .uploadProgress(queue: .main, closure: { progress in
               print("Upload Progress: \(progress.fractionCompleted)")
               
           }).responseJSON(completionHandler: { data in
               print("upload finished: \(data)")
               do {
                   
                  let decoder = JSONDecoder()
                         decoder.keyDecodingStrategy = .convertFromSnakeCase
                  let result = try decoder.decode(UploadPicModel.self, from: data.data!)
                  print("all data ->>>>>>",[result])
                  completion(.success(result))
   
                  }catch{
                    print(error)
                 }
               
           })
        
        /*
         .response { (response) in
             
               switch response.result {
                 case .failure(let error):
                 print(error)
                   //completion(error)
               case .success(_): break
                 
              }
         }
         */
     }
     

}
