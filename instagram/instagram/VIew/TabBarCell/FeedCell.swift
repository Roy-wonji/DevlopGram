//
//  FeedCell.swift
//  instagram
//
//  Created by 서원지 on 2022/04/27.
//

import UIKit
import Then

class FeedCell: UICollectionViewCell {
    //MARK:  - Properties
    private let profileImageView = UIImageView().then { imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
    }
    
    //MARK:  - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemPurple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
