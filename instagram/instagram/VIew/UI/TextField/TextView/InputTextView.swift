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
    
    private let placeHolderLabel = UILabel().then{ label in
        label.textColor = .lightGray
    }
    
    //MARK: - Lifecycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configureUI()
    }
    
    private func configureUI() {
        updateViews()
        setConstrantsPlaceHolderLabel()
    }
    
    private func updateViews() {
        addSubview(placeHolderLabel)
    }
    
    private func setConstrantsPlaceHolderLabel() {
        placeHolderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 6)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
