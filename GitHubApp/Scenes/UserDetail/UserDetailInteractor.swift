//
//  UserDetailInteractor.swift
//  GitHubApp
//
//  Created by Juliana Loaiza Labrador on 23/09/18.
//  Copyright (c) 2018 Juliana Loaiza Labrador. All rights reserved.
//

import UIKit

protocol UserDetailBusinessLogic
{
    func getUserDetail(userDetail: UserDetail.Request)
}

class UserDetailInteractor: UserDetailBusinessLogic
{
  var presenter: UserDetailPresentationLogic?

    func getUserDetail(userDetail: UserDetail.Request) {
        let viewModel = UserDetail.ViewModel(request: userDetail)
        presenter?.presentUserDetail(userDetail: viewModel)
    }
}
