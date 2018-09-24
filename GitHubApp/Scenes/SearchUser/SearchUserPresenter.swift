//
//  SearchUserPresenter.swift
//  GitHubApp
//
//  Created by Juliana Loaiza Labrador on 20/09/18.
//  Copyright (c) 2018 Juliana Loaiza Labrador. All rights reserved.
//

import UIKit

protocol SearchUserPresentationLogic
{
  func presentUser(response: GitHubUserModel)
  func presentError()
}

class SearchUserPresenter: SearchUserPresentationLogic
{
  weak var viewController: SearchUserDisplayLogic?
  
  // MARK: Do something
  
    func presentUser(response: GitHubUserModel) {
        let presenterResponse = GitHubUserModel.copy(with: response)
        presenterResponse.name = presenterResponse.name != nil ? presenterResponse.name : presenterResponse.login
        presenterResponse.name = "@\(String(describing: presenterResponse.name!))"
        viewController?.displayUser(user: presenterResponse)
    }
    
    func presentError() {
        viewController?.displayError()
    }
}
