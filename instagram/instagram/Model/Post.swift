//
//  Post.swift
//  instagram
//
//  Created by 서원지 on 2022/05/26.
//
import UIKit
import Firebase

struct Post {
    var caption: String
    var likes: Int
    var imageUrl: String
    let ownerUid: String
    let timestamp: Timestamp
    let postId: String
    let ownerImageUrl: String
    let ownerUsername: String
    var didLike =  false
    
    init(postId: String ,dictionary: [String: Any]) {
        self.postId = postId
        self.caption = dictionary["caption"] as? String ?? UserText.wrongInput
        self.likes = dictionary["likes"] as? Int ?? .zero
        self.imageUrl = dictionary["imageUrl"] as? String ?? UserText.wrongInput
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.ownerUid = dictionary["ownerUid"] as? String ?? UserText.wrongInput
        self.ownerImageUrl = dictionary["ownerImageUrl"] as? String ?? UserText.wrongInput
        self.ownerUsername = dictionary["ownerUsername"] as?  String ?? UserText.wrongInput
    }
}
