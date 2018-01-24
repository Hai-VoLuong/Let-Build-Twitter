//
//  HomeDataSource.swift
//  Twitter
//
//  Created by MAC on 1/15/18.
//

import LBTAComponents

class HomeDataSource: Datasource {
    
    let users: [User] = {
        let brianUser = User(name: "Test", userName: "@testtest", bioText: "Iphone, ipad , ios Programing Community. Join us to learn Swift, Object-C and build IOS apps" , profileImage: #imageLiteral(resourceName: "steve"))
        
        let rayUser = User(name: "Ray Wendelich", userName: "@raywendelich", bioText: "Ray Wendelich is Iphone developer  and tweets on topic iphone", profileImage: #imageLiteral(resourceName: "billget"))
        
        let kindleCourseUser = User(name: "Kindle Course", userName: "@kindle", bioText: "Iphone, ipad , ios Programing Community. Join us to learn Swift, Object-C and build IOS apps Ray Wendelich is Iphone developer  and tweets on topic iphone Iphone, ipad , ios Programing Community. Join us to learn Swift, Object-C and build IOS app", profileImage: #imageLiteral(resourceName: "steve"))
        
        return [brianUser, rayUser, kindleCourseUser]
    }()
    
    let tweets = ["tweet1", "tweet2"]
    
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
