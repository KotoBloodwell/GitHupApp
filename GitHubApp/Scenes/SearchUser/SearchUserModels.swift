//
//  SearchUserModels.swift
//  GitHubApp
//
//  Created by Juliana Loaiza Labrador on 20/09/18.
//  Copyright (c) 2018 Juliana Loaiza Labrador. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

enum GitHubUser
{
    // MARK: Use cases
    struct Request
    {
        var username: String?
        
        init(user:String?)
        {
            self.username = user
        }
    }
    struct ViewModel
    {
    }
}
