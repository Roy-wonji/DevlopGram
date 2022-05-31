//
//  CommentInputAcessoryView.swift
//  instagram
//
//  Created by 서원지 on 2022/05/31.
//

import UIKit
import Then

final class CommentInputAcessoryView: UIView {
    
    //MARK:  - Properties
    private lazy var commentTextView = InputTextView().then { textView in
        textView.placeHolderText =  "Enter comment ..."
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isScrollEnabled = false
        textView.placholderShouldCenter = true
    }
    
    private lazy var postButton = UIButton(type: .system).then { button in
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.textColorAsset, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handlePostTapped), for: .touchUpInside)
    }
    
    private lazy var dividerView = UIView().then { view in
        view.backgroundColor = .lightGray
    }
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        commentTextView.becomeFirstResponder()
    }
    //MARK: - UI
    private func configureUI() {
        updateVIew()
        updateConstraints()
        autoresizingMask = .flexibleHeight
    }
    
    private func updateVIew() {
        addSubview(postButton)
        addSubview(commentTextView)
        addSubview(dividerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    //MARK:  - Actions
    
    @objc func handlePostTapped( ) {
        
    }
    //MARK: - 오토레이아웃
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    private func setConstraints( ) {
        setConstraintsPostButton()
        setConstraintsCommentTextView()
        setConstraintsDividerView()
    }
    
    private func setConstraintsPostButton() {
        postButton.anchor(top: topAnchor, right: rightAnchor, paddingLeft: 8)
        postButton.setDimensions(height: 50, width: 50)
    }
    
    private func setConstraintsCommentTextView( ) {
        commentTextView.anchor(top: topAnchor, left: leftAnchor,
                               bottom: safeAreaLayoutGuide.bottomAnchor , right: postButton.leftAnchor,
                               paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
    }
    
    private func setConstraintsDividerView( ) {
        dividerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
    }
}
