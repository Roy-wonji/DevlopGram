//
//  UserCell.swift
//  instagram
//
//  Created by 서원지 on 2022/05/12.
//

import UIKit
import Then
import SDWebImage

final class UserCell: UITableViewCell {
    //MARK: - Properties
    
    var viewModel: UserCellViewModel? {
        didSet { configure()
            
        }
    }
    
    private lazy var profileImageView = UIImageView().then{ imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        imageView.image = UIImage(named: "Mini")
    }
    
    private lazy var usernameLabel = UILabel().then{ label in
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Mini"
    }
    
    private lazy var fullnameLabel = UILabel().then{ label in
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "아이들 민니"
        label.textColor = .lightGray
    }
    
    private lazy var stackView = UIStackView(arrangedSubviews: [usernameLabel, fullnameLabel]).then{stack in
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        
    }
    //MARK:  - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    private func  configureUI() {
        backgroundColor = .backgroundColor
        updateViews()
        setConstranits()
    }
    
    private func updateViews() {
        addSubview(profileImageView)
        addSubview(stackView)
        
    }
    
    private  func setConstranits() {
        setConstranitsProfileImageView()
        setConstranitsStackView()
    }
    
    private func setConstranitsProfileImageView() {
        profileImageView.setDimensions(height: 48, width: 48)
        profileImageView.layer.cornerRadius = 48 / 2
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
    }
    
    private func setConstranitsStackView() {
        stackView.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8 )
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let viewModel  = viewModel else { return }
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        usernameLabel.text = viewModel.username
        fullnameLabel.text = viewModel.fullname
    }
}
