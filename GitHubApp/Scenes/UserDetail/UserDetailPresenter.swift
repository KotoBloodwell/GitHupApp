//
//  UserDetailPresenter.swift
//  GitHubApp
//
//  Created by Juliana Loaiza Labrador on 23/09/18.
//  Copyright (c) 2018 Juliana Loaiza Labrador. All rights reserved.
//

import UIKit

protocol UserDetailPresentationLogic
{
    func presentUserDetail(userDetail: UserDetail.ViewModel)
}

class UserDetailPresenter: UserDetailPresentationLogic
{
    weak var viewController: UserDetailDisplayLogic?
    
    func presentUserDetail(userDetail: UserDetail.ViewModel) {
        let viewModel = formatValues(userDetail: userDetail)
        viewController?.displayUserDetail(viewModel: viewModel)
    }
    
    private func formatValues(userDetail: UserDetail.ViewModel) -> UserDetail.ViewModel {
        let viewModel = UserDetail.ViewModel.init(
            userIcon: userDetail.userIcon,
            userName: userDetail.userName,
            userCreatedDate: "UserCreatedAt".localizedWithArgs(args: userDetail.userCreatedDate),
            userUpdatedDate: "UserUpdatedAt".localizedWithArgs(args: userDetail.userUpdatedDate),
            userEmail: "UserEmail".localizedWithArgs(args: userDetail.userEmail),
            userBio: "UserBiography".localizedWithArgs(args: userDetail.userBio),
            userRepos: "UserRepositories".localizedWithArgs(args: userDetail.userRepos),
            userGists: "UserGists".localizedWithArgs(args: userDetail.userGists),
            userFollowers: "UserFollowers".localizedWithArgs(args: userDetail.userFollowers),
            userFollowing: "UserFollowing".localizedWithArgs(args: userDetail.userFollowing)
        )
        return viewModel
    }
    
}
