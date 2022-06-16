//
//  NotificationCell.swift
//  instagram
//
//  Created by 서원지 on 2022/06/10.
//

import UIKit
import Then

final class NotificationCell: UITableViewCell {
    //MARK: - Properties
    
    var viewModel: NotificationViewModel?  {
        didSet { configure() }
    }
    
    private lazy var profileImageView = UIImageView().then{ imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.image = UIImage(named: "Mini")
    }
    
    private lazy var infoLabel = UILabel().then{ label in
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = .zero
    }
    
    private lazy var postImageView = UIImageView().then { imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        let tap = UITapGestureRecognizer(target:  self, action: #selector(handlePostTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
    }
    
    private lazy var followButton = UIButton(type: .system).then { button in
        button.setTitle(NotificationText.followButtonText, for: .normal)
        button.layer.cornerRadius = 3
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.textColorAsset, for: .normal)
        button.addTarget(self, action: #selector(handleFollowButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    
    private func  configureUI()  {
        updateViews()
        updateConstraints()
        selectionStyle = .none
    }
    
    private func updateViews() {
        addSubview(profileImageView)
        addSubview(infoLabel)
        addSubview(followButton)
        addSubview(postImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc func handleFollowButtonTapped() {
        
    }
    
    @objc func handlePostTapped() {
        
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        postImageView.sd_setImage(with: viewModel.postImageurl)
        infoLabel.attributedText = viewModel.notificationMessage
    }
    
    //MARK: - UI
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    private func setConstraints() {
        setConstranitsProfileImageView()
        setConstranitsInfoLabel()
        setConstranitsFollowButton()
        setConstranitsPostImageView()
    }
    
    private func setConstranitsProfileImageView() {
        profileImageView.setDimensions(height: 48, width: 48)
        profileImageView.layer.cornerRadius = 48 / 2
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
    }
    
    private func setConstranitsInfoLabel() {
        infoLabel.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor,
                          paddingLeft: 8)
    }
    
    private func setConstranitsFollowButton() {
        followButton.centerY(inView: self)
        followButton.anchor(right: rightAnchor, paddingRight: 12, width: 100, height: 32)
        followButton.isHidden = true
    }
    
    private func setConstranitsPostImageView() {
        postImageView.centerY(inView: self)
        postImageView.anchor(right: rightAnchor, paddingRight: 12, width: 40, height: 40)
    }
}
