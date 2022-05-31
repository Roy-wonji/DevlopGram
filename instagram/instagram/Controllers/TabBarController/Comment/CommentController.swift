//
//  CommentController.swift
//  instagram
//
//  Created by 서원지 on 2022/05/31.
//

import UIKit

final class CommentController: UICollectionViewController {
    //MARK: - Properties
    
    //MARK:  - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
        cell.backgroundColor = .red
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension CommentController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 80)
    }
}
