//
//  MainViewController.swift
//  instagram
//
//  Created by 로이 on 2022/04/27.
//

import UIKit
import Firebase

final class MainTabViewController:  UITabBarController {
    //MARK:  - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        configureViewControllers()
    }
    
    //MARK: - API
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser ==  nil  {
            DispatchQueue.main.async {
                let controller = LoginController()
                let  navigation = UINavigationController(rootViewController: controller)
                navigation.modalPresentationStyle = .fullScreen
                self.present(navigation, animated: true, completion:  nil)
            }
        }
    }

    
    //MARK:  - Helpers
    private func configureViewControllers() {
        view.backgroundColor = .white
        let layout =  UICollectionViewFlowLayout( )
        let feed = tempateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"),  selectedImage:  #imageLiteral(resourceName: "home_selected") , rootViewController: FeedController(collectionViewLayout: layout))
        let search = tempateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_selected"),  selectedImage:  #imageLiteral(resourceName: "search_selected") , rootViewController: SearchController())
        let imageSelector = tempateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"),  selectedImage:  #imageLiteral(resourceName: "plus_unselected") , rootViewController: ImageSelectorController())
        let notifications = tempateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"),  selectedImage:  #imageLiteral(resourceName: "like_selected") , rootViewController: NotificationController())
        let profile = tempateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"),  selectedImage:  #imageLiteral(resourceName: "profile_selected") , rootViewController: ProfileController())
        viewControllers = [feed , search, imageSelector, notifications, profile]
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
    }
    //MARK: - tabbar 의 이미지가 선택 되었을때랑 안선택 되었을때 이미지 선택 해주는 함수
    private func tempateNavigationController(unselectedImage: UIImage, selectedImage: UIImage , rootViewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: rootViewController)
        navigation.tabBarItem.image = unselectedImage
        navigation.tabBarItem.selectedImage = selectedImage
        navigation.navigationBar.tintColor = .black
        return navigation
    }
}

