//
//  PostViewModel.swift
//  instagram
//
//  Created by 서원지 on 2022/05/27.
//

import Foundation

struct PostViewModel {
    private let post: Post
    
    var imageUrl : URL?  { return URL(string: post.imageUrl) }

    var caption: String { return post.caption }
    
    var likes: Int { return post.likes }
    
    init(post: Post) {
        self.post = post
    }
}
