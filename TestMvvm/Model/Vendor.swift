//
//  Vendor.swift
//  TestMvvm
//
//  Created by Harsh on 03/05/24.
//

import Foundation


struct Vendor:Codable {
    let id: String
    let type: String
    let countryId: String
    // Add other properties from the JSON response
    // Example:
    let firstName: String
    let lastName: String
    let userEmail: String
    // Add other properties as per your JSON response
    
    init(id:String,type:String,countryId:String,firstName:String,lastName:String,userEmail:String) {
        self.id = id
        self.type = type
        self.countryId = countryId
        self.firstName = firstName
        self.lastName = lastName
        self.userEmail = userEmail
    }
    
    
}
