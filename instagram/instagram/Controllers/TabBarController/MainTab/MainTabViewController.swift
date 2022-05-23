//
//  MainViewController.swift
//  instagram
//
//  Created by 로이 on 2022/04/27.
//

import UIKit
import Firebase
import YPImagePicker

final class MainTabViewController:  UITabBarController {
    //MARK:  - Lifecycle
    private var user : User? {
        didSet {
            guard let user = user else { return }
            configureViewControllers(withUser: user)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        checkIfUserIsLoggedIn()
    }
    
    private func configureUI() {
        fetchUser()
        tabBarController?.tabBar.barTintColor = .backgroundColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.defaultLabelColor]
        updateDelegate()
    }
    
    //MARK: - API
    private func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
        }
    }
    
    private  func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser ==  nil  {
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self
                let  navigation = UINavigationController(rootViewController: controller)
                navigation.modalPresentationStyle = .fullScreen
                self.present(navigation, animated: true, completion:  nil)
            }
        }
    }
    
    //MARK:  - Helpers
    private func configureViewControllers(withUser user: User) {
        view.backgroundColor = .white
        let layout =  UICollectionViewFlowLayout( )
        let feed = tempateNavigationController(unselectedImage: #imageLiteral(resourceName: "home_unselected"),  selectedImage:  #imageLiteral(resourceName: "home_selected") , rootViewController: FeedController(collectionViewLayout: layout))
        let search = tempateNavigationController(unselectedImage: #imageLiteral(resourceName: "search_selected"),  selectedImage:  #imageLiteral(resourceName: "search_selected") , rootViewController: SearchController())
        let imageSelector = tempateNavigationController(unselectedImage: #imageLiteral(resourceName: "plus_unselected"),  selectedImage:  #imageLiteral(resourceName: "plus_unselected") , rootViewController: ImageSelectorController())
        let notifications = tempateNavigationController(unselectedImage: #imageLiteral(resourceName: "like_unselected"),  selectedImage:  #imageLiteral(resourceName: "like_selected") , rootViewController: NotificationController())
        let profileController =  ProfileController(user: user)
        let profile = tempateNavigationController(unselectedImage: #imageLiteral(resourceName: "profile_unselected"),  selectedImage:  #imageLiteral(resourceName: "profile_selected") , rootViewController: profileController)
        
        viewControllers = [feed , search, imageSelector, notifications, profile]
        tabBar.tintColor = .tabBarColorAsset
        tabBar.backgroundColor = .backgroundColor
        tabBar.barTintColor = .defaultLabelColor
        view.backgroundColor = .backgroundColor
    }
    
    private func updateDelegate() {
        self.delegate = self
    }
    
    //MARK: - tabbar 의 이미지가 선택 되었을때랑 안선택 되었을때 이미지 선택 해주는 함수
    private func tempateNavigationController(unselectedImage: UIImage, selectedImage: UIImage , rootViewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: rootViewController)
        navigation.tabBarItem.image = unselectedImage
        navigation.tabBarItem.selectedImage = selectedImage
        navigation.navigationBar.tintColor = .textColorAsset
        return navigation
    }
    
    private func didFinishPickingMedia(_ picker: YPImagePicker) {
        picker.didFinishPicking { items, cancelled in
            picker.dismiss(animated: true) {
                guard let selectedImage = items.singlePhoto?.image else { return }
                
                let uploadController = UploadPostController()
                let navigation = UINavigationController(rootViewController: uploadController)
                navigation.modalPresentationStyle = .fullScreen
                self.present(navigation, animated: true, completion: nil)
            }
        }
    }
}

//MARK: - AuthenticationDelegate
extension MainTabViewController: AuthenticationDelegate {
    func authenticationDidComplete() {
        fetchUser()
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UITabBarControllerDelegate
extension MainTabViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        
        if index == 2 {
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo
            config.shouldSaveNewPicturesToAlbum = false
            config.startOnScreen = .library
            config.screens =  [.library]
            config.hidesStatusBar = false
            config.hidesBottomBar = false
            config.library.maxNumberOfItems = 1
            
            let picker  = YPImagePicker(configuration: config)
            picker.modalPresentationStyle = .fullScreen
            self.present(picker, animated: true, completion: nil)
            
            didFinishPickingMedia(picker)
        }
        
        return true
    }
}
