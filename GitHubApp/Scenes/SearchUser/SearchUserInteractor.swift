//
//  SearchUserInteractor.swift
//  GitHubApp
//
//  Created by Juliana Loaiza Labrador on 20/09/18.
//  Copyright (c) 2018 Juliana Loaiza Labrador. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

protocol SearchUserBusinessLogic
{
    func searchUser(user: GitHubUser.Request)
}

class SearchUserInteractor: SearchUserBusinessLogic
{
    var presenter: SearchUserPresentationLogic?
    var repositoryLocator = RepositoryLocator.sharedInstance.gitHubInfoRepository()
    let realm = try! Realm()
    
    // MARK: Do something
    
    func searchUser(user: GitHubUser.Request)
    {
        if let userGitHub = getUser(username: user.username!) {
            self.presenter?.presentUser(response: userGitHub)
        } else {
            repositoryLocator.getUserInfo(user: user) { (response: GitHubUserModel? , _ error: NSError?) in
                if error != nil  {
                    self.presenter?.presentError()
                } else {
                    if let gitHubUser = response  {
                        self.setUser(user: gitHubUser)
                        self.presenter?.presentUser(response: gitHubUser)
                    } else {
                        self.presenter?.presentError()
                    }
                }
            }
        }
    }
    
    private func setUser(user: GitHubUserModel) {
        try! realm.write {
            realm.add(user,update: true)
        }
    }
    
    private func getUser(username: String) -> GitHubUserModel? {
        if let gitHubUser = realm.objects(GitHubUserModel.self).filter("login == '\(username)'").first {
            return gitHubUser
        }
        return nil
    }
}
