//
//  MainTabController.swift
//  InstagramClone
//
//  Created by nandawperdana on 15/07/24.
//

import Foundation
import UIKit

class MainTabController: UITabBarController {
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewControllers()
    }
    
    // MARK: Configure UI
    private func configureViewControllers() {
        let feed = FeedController()
        
        let search = SearchController()
        
        let post = PostController()
        
        let notification = NotificationController()
        
        let profile = ProfileController()
        
        viewControllers = [feed, search, post, notification, profile]
    }
}
