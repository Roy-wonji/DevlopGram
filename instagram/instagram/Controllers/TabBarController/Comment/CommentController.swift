//
//  CommentController.swift
//  instagram
//
//  Created by 서원지 on 2022/05/31.
//

import UIKit

final class CommentController: UICollectionViewController {
    //MARK: - Properties
    private let post: Post
    private var comments = [Comment]()
    
    private lazy var commnetInputView: CommentInputAcessoryView = {
        let frame = CGRect(x: .zero, y: .zero, width: view.frame.width, height: 50)
        let commentView = CommentInputAcessoryView(frame: frame)
        commentView.delegate = self
        return commentView
    }()
    //MARK:  - Lifecycle
    init(post: Post) {
        self.post = post
        super.init(collectionViewLayout: UICollectionViewFlowLayout( ) )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchComments()
    }
    
    override var inputAccessoryView: UIView? {
        get { return commnetInputView }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - API
    func fetchComments( ) {
        DispatchQueue.main.async {
            CommentService.fetchComments(forPost: self.post.postId) { comments in
                self.comments = comments
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: - UI
    private func configureUI() {
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        navigationItem.title = "Comment"
        collectionView.backgroundColor = .backgroundColor
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textColorAsset ?? CommentUIText.colorWrongInput]
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CellIdentifier.commentResueIdentifier)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
    }
}

//MARK: - UICollectionViewController
extension CommentController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.commentResueIdentifier, for: indexPath)
        as! CommentCell
        cell.viewModel = CommentViewModel(comment: comments[indexPath.row])
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension CommentController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let uid  = comments[indexPath.row].uid
        UserService.fetchUser(withUid: uid) { user in
            let controller = ProfileController(user: user)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CommentController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = CommentViewModel(comment: comments[indexPath.row])
        let height = viewModel.size(forWidth: view.frame.width).height + 32
        return CGSize(width: view.frame.width, height: height)
    }
}

//MARK: - CommentInputAcessoryViewDelegate
extension CommentController: CommentInputAcessoryViewDelegate {
    func inputView(_ inputView: CommentInputAcessoryView, wnantTouploadComment comment: String) {
        guard let tab = self.tabBarController as? MainTabViewController else { return }
        guard let user = tab.user else { return }
        self.showLoader(true)
        CommentService.uploadComment(comment: comment, postID: post.postId, user: user) { erro in
            self.showLoader(false)
            inputView.clearCommentTextView()
        }
    }
}
