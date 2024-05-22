//
//  UploadPicModel.swift
//  TestMvvm
//
//  Created by Harsh on 09/05/24.
//

import Foundation

struct UploadPicModel: Decodable {
    let result : String?
    let path : String?
    let msg : String?
    let business_name : String?
    let data : UploadPicData
}

// MARK: - EmployeeData
struct UploadPicData: Decodable {

    let id,type,firstName,lastName,countryId: String
    let userEmail: String
    let about,approve,business_name,category_id,discription:String
    let expiration,fcm_id,google_id,is_subsc,landmark:String
    let lat,long,on_off,otp:String
    let sp_about,sp_business_name,sp_discription,sp_landmark,state_id:String
    let sub_ammount,sub_category_id,token,user_date,user_image:String
    let user_mobile,user_password,vendor_address,vendor_contact,vendor_date:String
    let vendor_email,vendor_lat,vendor_long,website,zip:String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case countryId = "countryId"
        case firstName = "firstName"
        case lastName = "lastName"
        case type = "type"
        case userEmail = "userEmail"
        case about = "about"
        case approve = "approve"
        case business_name = "businessName"
        case category_id = "categoryId"
        case discription = "discription"
        case expiration = "expiration"
        case fcm_id = "fcmId"
        case google_id = "googleId"
        case is_subsc = "isSubsc"
        case landmark = "landmark"
        case lat = "lat"
        case long = "long"
        case on_off = "onOff"
        case otp = "otp"
        case sp_about = "spAbout"
        case sp_business_name = "spBusinessName"
        case sp_discription = "spDiscription"
        case sp_landmark = "spLandmark"
        case state_id = "stateId"
        case sub_ammount = "subAmmount"
        case sub_category_id = "subCategoryId"
        case token = "token"
        case user_date = "userDate"
        case user_image = "userImage"
        case user_mobile = "userMobile"
        case user_password = "userPassword"
        case vendor_address = "vendorAddress"
        case vendor_contact = "vendorContact"
        case vendor_date = "vendorDate"
        case vendor_email = "vendorEmail"
        case vendor_lat = "vendorLat"
        case vendor_long = "vendorLong"
        case website = "website"
        case zip = "zip"
        
    }
    
}


