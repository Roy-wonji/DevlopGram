//
//  ProfileHeader.swift
//  instagram
//
//  Created by 서원지 on 2022/05/06.
//

import UIKit

final class ProfileHeader: UICollectionReusableView {
    //MARK:  - Properties
    private lazy var profileImageView = UIImageView().then { imageView  in
        imageView.image = UIImage(named: "venom-7")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateUI()
    }
    
    private func updateUI() {
        backgroundColor = .white
        configureUI()
        
    }
    
    private func configureUI() {
        setPostImageView()
    }
    
    private func setPostImageView() {
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 12)
        profileImageView.setDimensions(height: 80, width: 80)
        profileImageView.layer.cornerRadius = 80 / 2
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
