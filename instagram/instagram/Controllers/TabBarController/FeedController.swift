//
//  FeedController.swift
//  instagram
//
//  Created by 서원지 on 2022/04/27.
//

import UIKit

final class FeedController:  UICollectionViewController {
    //MARK:  - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: - UI 설정 하는 함수
    func configureUI() {
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: CellIdentifier.resueIdentifier)
    }
}
