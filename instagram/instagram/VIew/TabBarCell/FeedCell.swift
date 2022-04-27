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
    private lazy var  profileImageView = UIImageView().then { imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "venom-7")
    }
    
    private lazy var userNameButton  = UIButton(type: .system).then { button  in
        button.setTitleColor(.black, for: .normal)
        button.setTitle("venom", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(didTapUserName), for: .touchUpInside)
    }
    
    private lazy var postImageView = UIImageView().then { imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "venom-7")
    }
    
    private lazy var likeButton = UIButton(type: .system).then { button  in
        button.setImage(UIImage(named: "like_unselected"), for: .normal)
        button.tintColor = .black
    }
    
    private lazy var commentButton = UIButton(type: .system).then { button  in
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .black
    }
    
    private lazy var sharedButton = UIButton(type: .system).then { button  in
        button.setImage(UIImage(named: "send2"), for: .normal)
        button.tintColor = .black
    }
    
    private lazy var likesLabel = UILabel().then { label  in
        label.text = LabelMessage.likesLabelMessage
        label.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    private lazy var captionLabel = UILabel().then { label  in
        label.text = LabelMessage.captionLabelMessage
        label.font = UIFont.boldSystemFont(ofSize: 12)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:  - Actions
    @objc fileprivate func didTapUserName() {
        print("DEBUG: did tap username ")
    }
    
}
