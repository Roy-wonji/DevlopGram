//
//  InputTextView.swift
//  instagram
//
//  Created by 서원지 on 2022/05/23.
//

import UIKit
import Then

final class InputTextView : UITextView {
    
    //MARK: - Properties
    var placeHolderText: String? {
        didSet { placeHolderLabel.text = placeHolderText}
    }
    
    lazy var placeHolderLabel = UILabel().then{ label in
        label.textColor = .lightGray
    }
    
    var placholderShouldCenter = true {
        didSet {
            if placholderShouldCenter {
                placeHolderLabel.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 8)
                placeHolderLabel.centerY(inView: self)
            } else {
                placeHolderLabel.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 8)
            }
        }
    }
    //MARK: - Lifecycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configureUI()
    }
    
    private func configureUI() {
        updateViews()
        setConstrantsPlaceHolderLabel()
        configureNotificationObservers()
    }
    
    private func updateViews() {
        addSubview(placeHolderLabel)
    }
    
    private func setConstrantsPlaceHolderLabel() {
        placeHolderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 6)
    }
    
    private func  configureNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChnage),
                                               name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    @objc func handleTextDidChnage() {
        placeHolderLabel.isHidden = !text.isEmpty
    }
}
