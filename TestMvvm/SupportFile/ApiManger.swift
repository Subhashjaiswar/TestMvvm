//
//  ApiManger.swift
//  Boricua Directory
//
//  Created by mac on 10/08/23.
//

import Foundation
import Alamofire


class APIManager {
    
    
    class func headers() -> HTTPHeaders {
//        var headers: HTTPHeaders = [
//            "Content-Type": "application/json",
//            "Accept": "application/json"
//        ]
        var headers = HTTPHeaders()

       // if let authToken = UserDefaults.standard.string(forKey: "auth_token") {
            headers["Authorization"] = "$2y$10$q0rry5ijyA/2EwmJI7wVD.A/VmeSZhXGAp9k3kHqAjBJxENHTaxGi"
           // headers["Authorization"] = "Token" + " " + authToken
      //  }

        return headers
    }
   
}
