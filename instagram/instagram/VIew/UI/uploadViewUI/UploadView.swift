//
//  UploadView.swift
//  instagram
//
//  Created by 서원지 on 2022/05/23.
//

import UIKit
import Then

final class UploadView: UIView {
    //MARK: - Properties
    private let photoImageVIew = UIImageView().then{ imageView in
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds  = true
        imageView.image = UIImage(named: "Mini")
    }
    
    private let captionTextView = InputTextView().then{ textView in
        textView.placeHolderText = UploadImageText.placeHolderLabelText
        textView.font = UIFont.systemFont(ofSize: 16)
    }
    
    private let characterCountLabel = UILabel().then{ label in
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = UploadImageText.characterCountLabelText
    }
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateViews()
        updateConstraints()
    }
    
    private func updateViews() {
        addSubview(photoImageVIew)
        addSubview(captionTextView)
        addSubview(characterCountLabel)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    private func setConstraints() {
        setConstraintPhotoImageVIew()
        setConstraintCaptionTextView()
        setConstraintCharacterCountLabel()
    }
    
    private func setConstraintPhotoImageVIew() {
        photoImageVIew.setDimensions(height: 180, width: 180)
        photoImageVIew.anchor(top: self.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        photoImageVIew.centerX(inView: self)
        photoImageVIew.layer.cornerRadius = 10
    }
    
    private func setConstraintCaptionTextView() {
        captionTextView.anchor(top: photoImageVIew.bottomAnchor, left: self.leftAnchor,
                               right: self.rightAnchor, paddingTop: 16, paddingLeft: 12,
                               paddingRight: 12, height: 64)
    }
    
    private func setConstraintCharacterCountLabel() {
        characterCountLabel.anchor(bottom: captionTextView.bottomAnchor,
                                   right: self.rightAnchor, paddingRight: 12)
    }
}
