//
//  CommentController.swift
//  instagram
//
//  Created by 서원지 on 2022/05/31.
//

import UIKit

final class CommentController: UICollectionViewController {
    //MARK: - Properties
    
    private lazy var commnetInputView: CommentInputAcessoryView = {
        let frame = CGRect(x: .zero, y: .zero, width: view.frame.width, height: 50)
        let commentView = CommentInputAcessoryView(frame: frame)
        return commentView
    }()
    //MARK:  - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
    
    //MARK: - UI
    private func configureUI() {
        configureCollectionView()
    }
    
    private func configureCollectionView() {
        navigationItem.title = "Comment"
        collectionView.backgroundColor = .backgroundColor
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textColorAsset ?? CommentUIText.colorWrongInput]
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CellIdentifier.commentResueIdentifier)
    }
}

//MARK: - UICollectionViewController
extension CommentController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.commentResueIdentifier, for: indexPath)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CommentController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 80)
    }
}
