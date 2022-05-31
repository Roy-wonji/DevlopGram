//
//  CommentCell.swift
//  instagram
//
//  Created by 서원지 on 2022/05/31.
//

import UIKit
import Then

final  class CommentCell: UICollectionViewCell {
    
    //MARK: - Properties
    private lazy var profileImageView = UIImageView().then { imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
    }
    
    private lazy var commentLabel = UILabel().then { label in
        let attributedString = NSMutableAttributedString(string: CommentUIText.commentUser, attributes: [.font: UIFont.boldSystemFont(ofSize: 14) ] )
        attributedString.append(NSAttributedString(string: CommentUIText.commentText, attributes: [.font: UIFont.systemFont(ofSize: 14) ] ) )
        label.attributedText = attributedString
    }
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    private func configureUI() {
        updateView()
        updateConstraints()
    }
    
    private func updateView() {
        addSubview(profileImageView)
        addSubview(commentLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 오토 레이아웃
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    private func setConstraints() {
        setConstraintsProfileImageView()
        setConstraintsCommentLabel()
    }
    
    private func setConstraintsProfileImageView() {
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 8)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40 / 2
    }
    
    private func setConstraintsCommentLabel() {
        commentLabel.centerY(inView: profileImageView,
                             leftAnchor: profileImageView.rightAnchor,
                             paddingLeft: 8)
    }
}
