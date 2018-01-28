//
//  User.swift
//  Twitter
//
//  Created by MAC on 1/22/18.
//

import UIKit
import SwiftyJSON

struct User {
    let name: String
    let userName: String
    let bioText: String
    let profileImage: UIImage
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.userName = json["username"].stringValue
        self.bioText = json["bio"].stringValue
        self.profileImage = UIImage()
    }
}
