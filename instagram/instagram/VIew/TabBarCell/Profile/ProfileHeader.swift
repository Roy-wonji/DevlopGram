//
//  ProfileHeader.swift
//  instagram
//
//  Created by 서원지 on 2022/05/06.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    //MARK:  - Properties
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func updateUI() {
        backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
