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
    private var posts = [Post]() {
        didSet{ collectionView.reloadData() }
    }
    var post: Post?
    
    //MARK:  - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchPost()
    }
    
    //MARK: - API
    private func fetchPost() {
        DispatchQueue.main.async {
            guard self.post ==  nil else { return }
            PostService.fetchPosts { posts in
                self.posts = posts
                self.collectionView.refreshControl?.endRefreshing()
                self.checkIfUserLikedPosts()
            }
        }
    }
    
    private func checkIfUserLikedPosts() {
        self.posts.forEach { post in
            PostService.checkIfUserLikedPost(post: post) { didLike in
                if let index = self.posts.firstIndex(where: { $0.postId == post.postId }) {
                    self.posts[index].didLike = didLike
                }
            }
        }
    }
    
    //MARK: - UI 설정 하는 함수
    private func configureUI() {
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: CellIdentifier.resueIdentifier)
        naviagationTabBar()
    }
    
    private func naviagationTabBar() {
        navigationItem.title = "Feed"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textColorAsset ?? FeedUIText.colorWrongInput]
        tabBarController?.tabBar.barTintColor = .backgroundColor
        if post == nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem( title:  FeedUIText.leftBarItemText,
                                                                style: .plain,
                                                                target: self,
                                                                action: #selector(handleLogOut))
        }
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
}
//MARK: - UICollectionViewDataSource
extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post == nil ?  posts.count : 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.resueIdentifier, for:  indexPath) as! FeedCell
        cell.delegate = self
        if let post = post {
            cell.viewModel = PostViewModel(post: post)
        } else {
            cell.viewModel = PostViewModel(post: posts[indexPath.row])
        }
        cell.backgroundColor = .backgroundColor
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

//MARK: - FeedCellDelegate
extension FeedController: FeedCellDelegate {
    func cell(_ cell: FeedCell, wantsToShowProfileFor uid: String) {
        UserService.fetchUser(withUid: uid) { user in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func cell(_ cell: FeedCell, wantsToShowCommentsFor post: Post) {
        let controller  = CommentController(post: post)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func cell(_ cell: FeedCell, didLike post: Post) {
        guard let tab = self.tabBarController as? MainTabViewController else { return }
        guard let user = tab.user else { return }
        cell.viewModel?.post.didLike.toggle()
        if post.didLike {
            PostService.unlikePost(post: post) { error in
                cell.likeButton.setImage(UIImage(named: "like_unselected"), for: .normal)
                cell.likeButton.tintColor = .textColorAsset
                cell.viewModel?.post.likes = post.likes - 1
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        } else {
            PostService.likePost(post: post) { error in
                cell.likeButton.setImage(UIImage(named: "like_selected"), for: .normal)
                cell.likeButton.tintColor = .red
                cell.viewModel?.post.likes = post.likes + 1
                
                NotificationService.uploadNotification(toUid: post.ownerUid,
                                                       fromUser: user,
                                                       type: .like, post: post)
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
