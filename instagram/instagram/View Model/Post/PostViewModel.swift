//
//  PostViewModel.swift
//  instagram
//
//  Created by 서원지 on 2022/05/27.
//

import Foundation
import UIKit

struct PostViewModel {
    var post: Post
    
    var imageUrl : URL?  { return URL(string: post.imageUrl) }
    
    var userProfileImageUrl: URL? { return URL(string: post.ownerImageUrl) }
    
    var username: String { return post.ownerUsername }
    
    var caption: String { return post.caption }
    
    var likes: Int { return post.likes }
    
    var likeButtonTintColor: UIColor? {
        return post.didLike  ? .red  :  .textColorAsset
    }
    
    var likeButtonImage: UIImage? {
        let imageName = post.didLike ? "like_selected" : "like_unselected"
        return  UIImage(named: imageName)
    }
    
    var likesLabelText: String {
        if post.likes  != 1 {
            return "\(post.likes) likes"
        } else {
            return "\(post.likes) like"
        }
    }
    
    init(post: Post) {
        self.post = post
    }
}
