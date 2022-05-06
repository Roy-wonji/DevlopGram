//
//  ProfileCell.swift
//  instagram
//
//  Created by 서원지 on 2022/05/06.
//

import UIKit
import Then

final class ProfileCell: UICollectionViewCell {
    //MARK:  - Properties
    private lazy var postImageView = UIImageView().then { imageView  in
        imageView.image = UIImage(named: <#T##String#>)
    }
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateUI()
    }
    
    private func updateUI() {
        backgroundColor = .lightGray
        configureUI()
    }
    
    private func configureUI() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
