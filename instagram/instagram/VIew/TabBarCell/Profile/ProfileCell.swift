//
//  ProfileCell.swift
//  instagram
//
//  Created by 서원지 on 2022/05/06.
//

import UIKit

final class ProfileCell: UICollectionViewCell {
    //MARK:  - Properties
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func updateUI() {
        backgroundColor = .lightGray
        configureUI()
    }
    
    private func configureUI() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
