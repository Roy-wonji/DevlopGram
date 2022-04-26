//
//  MainViewController.swift
//  instagram
//
//  Created by 로이 on 2022/04/27.
//

import UIKit

final class MainTabViewController:  UITabBarController {
    
    //MARK:  - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }

    //MARK:  - Helpers
    
    func configureViewControllers() {
        view.backgroundColor = .white
        
        let feed = FeedController()
        let search = SearchController()
        let imageSelector = ImageSelectorController()
        let notifications = NotificationController()
        let profile = ProfileController()
        viewControllers = [feed , search, imageSelector, notifications, profile]
    }

}

