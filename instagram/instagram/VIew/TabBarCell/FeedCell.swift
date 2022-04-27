//
//  FeedCell.swift
//  instagram
//
//  Created by 서원지 on 2022/04/27.
//

import UIKit

class FeedCell: UICollectionViewCell {
    //MARK:  - Properties
    
    //MARK:  - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemPurple
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
