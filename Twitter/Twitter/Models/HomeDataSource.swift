//
//  HomeDataSource.swift
//  Twitter
//
//  Created by MAC on 1/15/18.
//

import LBTAComponents
import TRON
import SwiftyJSON

class HomeDataSource: Datasource, JSONDecodable {
    
    let users: [User]
    let tweets: [Tweet]
    
    required init(json: JSON) throws {
        
        var users = [User]()
        let array = json["users"].array
        for userJson in array! {
            let name = userJson["name"].stringValue
            let username = userJson["username"].stringValue
            let bio = userJson["bio"].stringValue
            
            let user = User(name: name, userName: username, bioText: bio, profileImage: UIImage())
            users.append(user)
        }
        
        var tweets = [Tweet]()
        let tweetsJsonArray = json["tweets"].array
        for tweetJson in tweetsJsonArray! {
            let useJson = tweetJson["user"]
            
            let name = useJson["name"].stringValue
            let username = useJson["username"].stringValue
            let bio = useJson["bio"].stringValue
            let user = User(name: name, userName: username, bioText: bio, profileImage: UIImage())
            let message = tweetJson["message"].stringValue
            let tweet = Tweet(user: user, message: message)
            tweets.append(tweet)
        }
        
        self.users = users
        self.tweets = tweets
    }
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [UserFooter.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [UserHeader.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [UserCell.self, TweetCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if indexPath.section == 1 {
            return tweets[indexPath.item]
        }
        return users[indexPath.item]
    }
    
    override func numberOfSections() -> Int {
        return 2
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        if section == 1 {
            return tweets.count
        }
        return users.count
    }
}
