//
//  FinalUserModel.swift
//  TestMvvm
//
//  Created by Harsh on 03/05/24.
//

import Foundation

struct FavraiteModel: Decodable {
    let result : String?
    let msg : String?
    let data : [FavraiteData]
}

// MARK: - FavraiteData
struct FavraiteData: Decodable {

    let id,business_logo,rating,sp_business_name,vendor_contact: String
    let category_name,business_name: String
    let sp_name,fav_id,fav_date,favourite:String
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case business_logo = "businessLogo"
        case rating = "rating"
        case sp_business_name = "spBusinessName"
        case vendor_contact = "vendorContact"
        case category_name = "categoryName"
        case business_name = "businessName"
        case sp_name = "spName"
        case fav_id = "favId"
        case fav_date = "favDate"
        case favourite = "favourite"
        
    }
    
}


