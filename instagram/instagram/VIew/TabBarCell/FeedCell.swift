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
        imageView.image = UIImage(named: "venom-7")
    }
    
    //MARK:  - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        
    }
    
    func configureUI() {
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.anchor(top : topAnchor,
                                left: leftAnchor ,
                                paddingTop: 12 ,
                                paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40 / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
