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
    
    var viewModel: PostViewModel? {
        didSet{ configure() }
    }
    
    private lazy var postImageView = UIImageView().then { imageView  in
        imageView.image = UIImage(named: "Mini2")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateUI()
    }
    
    private func updateUI() {
        configureUI()
    }
    
    private func configureUI() {
        setPostImageView()
    }
    
    private func setPostImageView() {
        addSubview(postImageView)
        postImageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        postImageView.sd_setImage(with: viewModel.imageUrl)
    }
}
