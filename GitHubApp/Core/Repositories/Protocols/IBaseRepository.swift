//
//  IBaseRepository.swift
//  GitHubApp
//
//  Created by Juliana Loaiza Labrador on 20/09/18.
//  Copyright © 2018 Juliana Loaiza Labrador. All rights reserved.
//

import Foundation


protocol IBaseRepository {
    
   // func getData(filter: String, completionHandler:@escaping (_ response: [SearchBook.Book]?, _ error: NSError?) -> Void)
    func getUserInfo(user: GitHubUser.Request, completionHandler: @escaping (GitHubUserModel?, NSError?) -> Void)
}
