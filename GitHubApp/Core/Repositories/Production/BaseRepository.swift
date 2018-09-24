//
//  BaseRepository.swift
//  GitHubApp
//
//  Created by Juliana Loaiza Labrador on 20/09/18.
//  Copyright © 2018 Juliana Loaiza Labrador. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class BaseRepository: IBaseRepository {
    
    static let sharedInstance = BaseRepository()
    
    class var sharedDispatchInstance: BaseRepository {
        struct Static {
            static var onceToken = NSUUID().uuidString
            static var instance: BaseRepository? = nil
        }
        DispatchQueue.once(token: Static.onceToken) {
            Static.instance = BaseRepository()
        }
        return Static.instance!
    }
    
    class var sharedStructInstance: BaseRepository {
        struct Static {
            static let instance = BaseRepository()
        }
        return Static.instance
    }
    
    func getUserInfo(user: GitHubUser.Request, completionHandler: @escaping (GitHubUserModel?, NSError?) -> Void) {
        Alamofire.request("\(URLsOperationServices.getUserInfo.description)\(String(describing: user.username!))", method: HTTPMethod.get, encoding: JSONEncoding.default, headers: nil).validate().responseJSON {
            (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                let decoder = JSONDecoder()
                if let data = response.data ,let gitHubUser = try? decoder.decode(GitHubUserModel.self, from: data) {
                    completionHandler(gitHubUser,nil)
                }
                break
            case .failure(_):
                completionHandler(nil,nil)
                break
            }
        }
    }
    
}
