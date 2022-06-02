//
//  CommentViewmodel.swift
//  instagram
//
//  Created by 서원지 on 2022/06/02.
//

import UIKit

struct CommentViewModel {
    
    private let comment: Comment
    
    var profileImageUrl: URL? { return URL(string: comment.profileImageUrl) }
    
    var username: String { return comment.username }
    
    var commentText: String { return comment.commentText }
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    func  commentLabelText() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(username)", attributes: [.font: UIFont.boldSystemFont(ofSize: 14) ] )
        
        attributedString.append(NSAttributedString(string: commentText, attributes: [.font: UIFont.systemFont(ofSize: 14) ] ) )
        return attributedString
    }
    
    func size(forWidth width:CGFloat) -> CGSize {
        let label = UILabel()
        label.numberOfLines = .zero
        label.text = comment.commentText
        label.lineBreakMode = .byWordWrapping
        label.setWidth(width)
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
