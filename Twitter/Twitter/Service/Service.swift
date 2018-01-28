//
//  Service.swift
//  Twitter
//
//  Created by MAC on 1/27/18.
//

import Foundation
import TRON
import SwiftyJSON

struct Service {
    
    let tron = TRON(baseURL: "https://api.letsbuildthatapp.com")
    
    static let sharedInstance = Service()

    func fetchHomeFeed(completion: @escaping (HomeDataSource?, Error?) -> ()) {
        let request: APIRequest<HomeDataSource, JSONError> = tron.swiftyJSON.request("/twitter/home")
        request.perform(withSuccess: { (homeDataSource) in
            completion(homeDataSource, nil)
        }) { (error) in
            completion(nil , error)
        }
    }
    
    class JSONError: JSONDecodable {
        required init(json: JSON) throws {
            print("json Error")
        }
    }
}
