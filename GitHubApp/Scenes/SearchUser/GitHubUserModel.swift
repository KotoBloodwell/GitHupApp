//
//  GitHubUserModel.swift
//  GitHubApp
//
//  Created by Juliana Loaiza Labrador on 23/09/18.
//  Copyright © 2018 Juliana Loaiza Labrador. All rights reserved.
//

import RealmSwift
import Realm

class GitHubUserModel: Object, Codable
{
    @objc dynamic var login: String?
    @objc dynamic var avatar_url: String?
    @objc dynamic var url: String?
    @objc dynamic var html_url: String?
    @objc dynamic var followers_url: String?
    @objc dynamic var subscriptions_url: String?
    @objc dynamic var organizations_url: String?
    @objc dynamic var repos_url: String?
    @objc dynamic var events_url: String?
    @objc dynamic var type: String?
    @objc dynamic var name: String?
    @objc dynamic var company: String?
    @objc dynamic var email: String?
    @objc dynamic var bio: String?
    @objc dynamic var public_repos: Int = 0
    @objc dynamic var public_gists: Int = 0
    @objc dynamic var followers: Int = 0
    @objc dynamic var following: Int = 0
    @objc dynamic var created_at: String?
    @objc dynamic var updated_at: String?
    
    init(login: String?,avatar_url: String?,url: String?,html_url: String?,followers_url: String?,subscriptions_url: String?,organizations_url: String?,repos_url: String?,events_url: String?,type: String?,name: String?,company: String?,email: String?,bio: String?,public_repos: Int,public_gists: Int,followers: Int,following: Int,created_at: String?,updated_at: String?) {
        super.init()
        self.login = login
        self.avatar_url = avatar_url
        self.url = url
        self.html_url = html_url
        self.followers_url = followers_url
        self.subscriptions_url = subscriptions_url
        self.organizations_url = organizations_url
        self.repos_url = repos_url
        self.events_url = events_url
        self.type = type
        self.name = name
        self.company = company
        self.email = email
        self.bio = bio
        self.public_repos = public_repos
        self.public_gists = public_gists
        self.followers = followers
        self.following = following
        self.created_at = created_at
        self.updated_at = updated_at
    }
    
    override static func primaryKey() -> String? {
        return "login"
    }
    
    class func copy(with gitHubUser: GitHubUserModel? = nil) -> GitHubUserModel {
        let copy = GitHubUserModel.init(login: gitHubUser?.login, avatar_url: gitHubUser?.avatar_url, url: gitHubUser?.url, html_url: gitHubUser?.html_url, followers_url: gitHubUser?.followers_url, subscriptions_url: gitHubUser?.subscriptions_url, organizations_url: gitHubUser?.organizations_url, repos_url: gitHubUser?.repos_url, events_url: gitHubUser?.events_url, type: gitHubUser?.type, name: gitHubUser?.name, company: gitHubUser?.company, email: gitHubUser?.email, bio: gitHubUser?.bio, public_repos: gitHubUser?.public_repos ?? 0, public_gists: gitHubUser?.public_gists ?? 0, followers: gitHubUser?.followers ?? 0, following: gitHubUser?.following ?? 0, created_at: gitHubUser?.created_at, updated_at: gitHubUser?.updated_at)
        return copy
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
}
