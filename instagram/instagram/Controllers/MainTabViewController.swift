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
        let feed = tempateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"),  selectedImage:  #imageLiteral(resourceName: "home_selected") , rootViewController: FeedController())
        let search = tempateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_selected"),  selectedImage:  #imageLiteral(resourceName: "search_selected") , rootViewController: SearchController())
        let imageSelector = tempateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"),  selectedImage:  #imageLiteral(resourceName: "plus_unselected") , rootViewController: ImageSelectorController())
        let notifications = tempateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"),  selectedImage:  #imageLiteral(resourceName: "like_selected") , rootViewController: NotificationController())
        let profile = tempateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"),  selectedImage:  #imageLiteral(resourceName: "profile_selected") , rootViewController: ProfileController())
        viewControllers = [feed , search, imageSelector, notifications, profile]
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
    }
    
    func tempateNavigationController(unselectedImage: UIImage, selectedImage: UIImage , rootViewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: rootViewController)
        navigation.tabBarItem.image = unselectedImage
        navigation.tabBarItem.selectedImage = selectedImage
        navigation.navigationBar.tintColor = .black
        return navigation
    }
}

