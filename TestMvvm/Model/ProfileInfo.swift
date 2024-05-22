
import Foundation
import SwiftUI
import UIKit
struct ProfileInfo : Codable {
    let img : String?
    let email : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {

        case img = "img"
        case email = "email"
        case name = "name"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        img = try values.decodeIfPresent(String.self, forKey: .img)
        
    }

}

