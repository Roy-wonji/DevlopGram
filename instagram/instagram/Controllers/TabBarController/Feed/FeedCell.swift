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
    var viewModel:  PostViewModel? {
        didSet { configure() }
    }
    
    weak var delegate: FeedCellDelegate?
    
    private lazy var  profileImageView = UIImageView().then { imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = .lightGray
    }
    
    private lazy var userNameButton  = UIButton(type: .system).then { button  in
        button.setTitleColor(.textColorAsset, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(didTapUserName), for: .touchUpInside)
    }
    
    private lazy var postImageView = UIImageView().then { imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "Mini2")
    }
    
     lazy var likeButton = UIButton(type: .system).then { button  in
        button.setImage(UIImage(named: "like_unselected"), for: .normal)
        button.tintColor = .textColorAsset
        button.addTarget(self, action: #selector(didTapLIke), for: .touchUpInside)
    }
    
    private lazy var commentButton = UIButton(type: .system).then { button  in
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .textColorAsset
        button.addTarget(self, action: #selector(didTapComment), for: .touchUpInside)
    }
    
    private lazy var sharedButton = UIButton(type: .system).then { button  in
        button.setImage(UIImage(named: "send2"), for: .normal)
        button.tintColor = .textColorAsset
    }
    
    private lazy var likesLabel = UILabel().then { label  in
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = .textColorAsset
    }
    
    private lazy var captionLabel = UILabel().then { label  in
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .textColorAsset
    }
    
    private lazy var postTimeLabel = UILabel().then { label  in
        label.text = LabelMessage.postTimeLabelMessage
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
    }
    
    //MARK:  - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    func configureUI() {
        backgroundColor = .white
        setLayout()
    }
    
    private func setLayout() {
        setProfileImageView()
        setUsernameButton()
        setPostImageView()
        setStackView()
        setLikesLabel()
        setCaptionLabel()
        setPostTimeLabel()
    }
    
    private func setProfileImageView() {
        addSubview(profileImageView)
        profileImageView.anchor(top : topAnchor,
                                left: leftAnchor ,
                                paddingTop: 12 ,
                                paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40 / 2
    }
    
    private func setUsernameButton() {
        addSubview(userNameButton)
        userNameButton.centerY(inView: profileImageView,
                               leftAnchor: profileImageView.rightAnchor, paddingLeft:  8 )
    }
    
    private func setPostImageView() {
        addSubview(postImageView)
        postImageView.anchor(top: profileImageView.bottomAnchor,  left: leftAnchor,
                             right: rightAnchor, paddingTop: 8 )
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
    }
    
    private func setStackView() {
        configureActionButtons()
    }
    
    private func setLikesLabel() {
        addSubview(likesLabel)
        likesLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, paddingTop: -4, paddingLeft: 8)
    }
    
    private func setCaptionLabel() {
        addSubview(captionLabel)
        captionLabel.anchor(top: likesLabel.bottomAnchor, left: leftAnchor, paddingTop: 8 , paddingLeft: 8)
    }
    
    private func setPostTimeLabel() {
        addSubview(postTimeLabel)
        postTimeLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, paddingTop: 8 , paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:  - Actions
    @objc func didTapUserName() {
        print("DEBUG: did tap username ")
    }
    
    @objc func didTapComment() {
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, wantsToShowCommentsFor: viewModel.post)
    }
    
    @objc func didTapLIke() {
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, didLike: viewModel.post)
    }
    
    //MARK:  - Helpers
    private func configure( ) {
        DispatchQueue.main.async {
            guard let viewModel = self.viewModel else { return }
            self.captionLabel.text = viewModel.caption
            self.postImageView.sd_setImage(with: viewModel.imageUrl)
            
            self.profileImageView.sd_setImage(with: viewModel.userProfileImageUrl)
            self.userNameButton.setTitle(viewModel.username, for: .normal)
            self.likesLabel.text = viewModel.likesLabelText
        }
    }
    
    //MARK: - configureActionButtons
    func configureActionButtons() {
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, sharedButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.anchor(top: postImageView.bottomAnchor, width: 120, height: 50)
    }
}
