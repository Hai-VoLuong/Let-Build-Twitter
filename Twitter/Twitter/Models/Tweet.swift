//
//  Tweet.swift
//  Twitter
//
//  Created by MAC on 1/24/18.
//

import Foundation
import SwiftyJSON

struct Tweet {
    let user: User
    let message: String
    
    init(json: JSON) {
        let userJSon = json["user"]
        self.user = User(json: userJSon)
        
        self.message = json["message"].stringValue
    }
}
