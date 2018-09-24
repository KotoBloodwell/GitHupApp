//
//  UserDetailModels.swift
//  GitHubApp
//
//  Created by Juliana Loaiza Labrador on 23/09/18.
//  Copyright (c) 2018 Juliana Loaiza Labrador. All rights reserved.
//

import UIKit
import RealmSwift

enum UserDetail
{
  // MARK: Use cases
  typealias Request = GitHubUserModel

  struct ViewModel
  {
    var userIcon: String
    var userName: String
    var userCreatedDate: String
    var userUpdatedDate: String
    var userEmail: String
    var userBio: String
    var userRepos: String
    var userGists: String
    var userFollowers: String
    var userFollowing: String

    init(request: Request) {
        let defaultLabel = "ContentNotAvalaible".localized()
        userIcon = request.avatar_url ?? String()
        userName = request.name ?? request.login ?? defaultLabel
        userCreatedDate = request.created_at?.stringDateFormatShort() ?? defaultLabel
        userUpdatedDate = request.updated_at?.stringDateFormatShort() ?? defaultLabel
        userEmail = request.email ?? defaultLabel
        userBio = request.bio ?? defaultLabel
        userRepos = request.public_repos.description
        userGists = request.public_gists.description
        userFollowers = request.followers.description
        userFollowing = request.following.description
    }
    
    init(userIcon: String, userName: String, userCreatedDate: String, userUpdatedDate: String, userEmail: String, userBio: String, userRepos: String, userGists: String, userFollowers: String, userFollowing: String) {
        self.userIcon = userIcon
        self.userName = userName
        self.userCreatedDate = userCreatedDate
        self.userUpdatedDate = userUpdatedDate
        self.userEmail = userEmail
        self.userBio = userBio
        self.userRepos = userRepos
        self.userGists = userGists
        self.userFollowers = userFollowers
        self.userFollowing = userFollowing
    }
  }
}
