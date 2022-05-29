//
//  FeedController.swift
//  instagram
//
//  Created by 서원지 on 2022/04/27.
//

import UIKit
import Firebase

final class FeedController:  UICollectionViewController {
    
    //MARK: - Properties
    
    private var posts = [Post]()
    //MARK:  - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchPost()
    }
    
    //MARK: - UI 설정 하는 함수
    func configureUI() {
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: CellIdentifier.resueIdentifier)
        naviagationTabBar()
    }
    
    
    private func naviagationTabBar() {
        tabBarController?.tabBar.barTintColor = .backgroundColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textColorAsset]
        navigationItem.leftBarButtonItem = UIBarButtonItem( title:  FeedUIText.leftBarItemText,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(handleLogOut))
        navigationItem.title = "Feed"
        
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
    
    //MARK: - Actions
    @objc func handleRefresh() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.fetchPost()
        }
    }
    
    @objc func handleLogOut() {
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            controller.delegate = self.tabBarController as? MainTabViewController
            let  navigation = UINavigationController(rootViewController: controller)
            navigation.modalPresentationStyle = .fullScreen
            self.present(navigation, animated: true, completion:  nil)
        } catch { print("DEBUG:  Falied  to  sign  out") }
    }
    //MARK: - API
    func fetchPost() {
        DispatchQueue.main.async {
            PostService.fetchPosts { posts in
                self.posts = posts
                self.collectionView.refreshControl?.endRefreshing()
                self.collectionView.reloadData()
            }
        }
    }
    
    
}
//MARK: - UICollectionViewDataSource
extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.resueIdentifier, for:  indexPath) as! FeedCell
        cell.backgroundColor = .backgroundColor
        cell.viewModel = PostViewModel(post: posts[indexPath.row])
        return cell
    }
}
//MARK:  - UICollectionViewDelegateFlowLayout
extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        return CGSize(width: width, height: height)
    }
}
