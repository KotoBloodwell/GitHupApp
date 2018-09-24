//
//  UserDetailViewController.swift
//  GitHubApp
//
//  Created by Juliana Loaiza Labrador on 23/09/18.
//  Copyright (c) 2018 Juliana Loaiza Labrador. All rights reserved.
//

import UIKit

protocol UserDetailDisplayLogic: class
{
    func displayUserDetail(viewModel: UserDetail.ViewModel)
}

class UserDetailViewController: UIViewController, UserDetailDisplayLogic
{
    var interactor: UserDetailBusinessLogic?
    var router: (NSObjectProtocol & UserDetailRoutingLogic)?
    var gitHubUserSelected: GitHubUserModel?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = UserDetailInteractor()
        let presenter = UserDetailPresenter()
        let router = UserDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUserDetail()
    }
    
    // MARK: Do something
    
    @IBOutlet weak var UserIcon: UIImageView!
    @IBOutlet weak var UserNameView: UIView!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var DetailStackView: UIStackView!
    @IBOutlet weak var UserCreatedDate: UILabel!
    @IBOutlet weak var UserUpdatedDate: UILabel!
    @IBOutlet weak var UserEmail: UILabel!
    @IBOutlet weak var UserBiography: UITextView!
    @IBOutlet weak var UserPublicRepositories: UILabel!
    @IBOutlet weak var UserPublicGist: UILabel!
    @IBOutlet weak var UserFollowers: UILabel!
    @IBOutlet weak var UserFollowing: UILabel!
    
    @IBOutlet weak var UserNameHLView: HyperLinkVIew!
    @IBOutlet weak var PublicReposHLView: HyperLinkVIew!
    @IBOutlet weak var FollowerHLView: HyperLinkVIew!
    @IBOutlet weak var FollowingHLView: HyperLinkVIew!
    
    
    private func setupUserDetail(){
        if let user = gitHubUserSelected {
            interactor?.getUserDetail(userDetail: user)
        }
    }
    
    func displayUserDetail(viewModel: UserDetail.ViewModel) {
        UserIcon.imageFromServerURL(urlString: viewModel.userIcon)
        UserNameLabel.text = viewModel.userName
        UserCreatedDate.text = viewModel.userCreatedDate
        UserUpdatedDate.text = viewModel.userUpdatedDate
        UserEmail.text = viewModel.userEmail
        UserBiography.text = viewModel.userBio
        UserPublicRepositories.text = viewModel.userRepos
        UserPublicGist.text = viewModel.userGists
        UserFollowers.text = viewModel.userFollowers
        UserFollowing.text = viewModel.userFollowing
        
        if let nickName =  gitHubUserSelected?.login {
            setHyperLinks(username: nickName)
        }
    }
    
    private func setHyperLinks(username: String){
        UserNameHLView.hyperLink = "GitHubURL".localizedWithArgs(args: username)
        PublicReposHLView.hyperLink = "GitHubURLRepos".localizedWithArgs(args: username)
        FollowerHLView.hyperLink = "GitHubURLFollowers".localizedWithArgs(args: username)
        FollowingHLView.hyperLink = "GitHubURLFollowing".localizedWithArgs(args: username)
    }
    
    @IBAction func dismissViewController(_ sender: Any) {
        hideViewsOnPopViewController()
        navigationController?.popViewController(animated: true)
    }
    
    private func hideViewsOnPopViewController(){
        closeButton.isHidden = true
        DetailStackView.isHidden = true
    }
}

extension UserDetailViewController: Scaling {
    func scalingUILabel(transition: ScaleTransitionDelegate) -> UILabel? {
        return UserNameLabel
    }
    
    func scalingImageView(transition: ScaleTransitionDelegate) -> UIImageView? {
        return UserIcon
    }
}
