//
//  BaseRepositoryTest.swift
//  GitHubApp
//
//  Created by Juliana Loaiza Labrador on 20/09/18.
//  Copyright © 2018 Juliana Loaiza Labrador. All rights reserved.
//

import Foundation

class BaseRepositoryTest: IBaseRepository {
    
    static let sharedInstance = BaseRepositoryTest()
    
    class var sharedDispatchInstance: BaseRepositoryTest {
        struct Static {
            static var onceToken = NSUUID().uuidString
            static var instance: BaseRepositoryTest? = nil
        }
        DispatchQueue.once(token: Static.onceToken) {
            Static.instance = BaseRepositoryTest()
        }
        return Static.instance!
    }
    
    class var sharedStructInstance: BaseRepositoryTest {
        struct Static {
            static let instance = BaseRepositoryTest()
        }
        return Static.instance
    }
    func getUserInfo(user: GitHubUser.Request, completionHandler: @escaping (GitHubUserModel?, NSError?) -> Void) {
            completionHandler(nil,nil)
    }
    
}
