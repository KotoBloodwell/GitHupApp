//
//  SearchUserViewController.swift
//  GitHubApp
//
//  Created by Juliana Loaiza Labrador on 20/09/18.
//  Copyright (c) 2018 Juliana Loaiza Labrador. All rights reserved.
//

import UIKit

protocol SearchUserDisplayLogic: class
{
    func displayUser(user: GitHubUserModel)
    func displayError()
}

class SearchUserViewController: UIViewController, SearchUserDisplayLogic
{
    var interactor: SearchUserBusinessLogic?
    var router: (NSObjectProtocol & SearchUserRoutingLogic)?
    
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
        let interactor = SearchUserInteractor()
        let presenter = SearchUserPresenter()
        let router = SearchUserRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupViewController()
    }
    
    // MARK: Do something
    
    @IBOutlet weak var UserNameUIView: UIView!
    @IBOutlet weak var ContentView: UIStackView!
    @IBOutlet weak var BodyUIView: UIView!
    @IBOutlet weak var NoUserFoundLabel: UILabel!
    @IBOutlet weak var UserIcon: UIImageView!
    @IBOutlet weak var UserNameUILabel: UILabel!
    
    var gitHubUser: GitHubUserModel?
    
    func searchUser(username: String)
    {
        interactor?.searchUser(user:GitHubUser.Request(user: username))
    }
    
    func displayUser(user: GitHubUserModel){
        gitHubUser = user
        UserNameUILabel.text = user.name
        UserIcon.imageFromServerURL(urlString: user.avatar_url ?? "")
        displayBodySearch(display: true)
    }
    
    func displayError() {
        displayBodySearch(display: false)
    }
    
    private func setupViewController(){
        // Hide Navigation Bar
        self.navigationController?.isNavigationBarHidden = true
        
        // Add Gestures
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(goToDetail))
        ContentView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func goToDetail(){
        self.performSegue(withIdentifier: "segueToDetail", sender: self)
    }
    
    private func displayBodySearch(display: Bool) {
        displayReplaceAnimation(replace: display)
    }
    
    private func displayReplaceAnimation(replace: Bool){
        // Content to animate
        let initialContent: UIView = NoUserFoundLabel
        let newContent: UIView = ContentView
        
        // Play the animation
        UIViewAnimations.replaceContentFromAbove(currentView: self.view, initialContent: initialContent, newContent: newContent, reverse: replace) {
            if replace {
                UIViewAnimations.shake(viewLayer: self.UserNameUIView.layer)
                UIViewAnimations.shake(viewLayer: self.BodyUIView.layer)
            }
        }
    }
}

// MARK: - SearchBarDelegate
extension SearchUserViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let username = searchBar.text {
            searchUser(username: username)
        } else {
            displayError()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - Scaling
extension SearchUserViewController: Scaling {
    func scalingUILabel(transition: ScaleTransitionDelegate) -> UILabel? {
        return UserNameUILabel
    }
    
    func scalingImageView(transition: ScaleTransitionDelegate) -> UIImageView? {
        return UserIcon
    }
    
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! UserDetailViewController
        destinationVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        destinationVC.gitHubUserSelected = self.gitHubUser
        
    }
}
