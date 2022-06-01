//
//  Comment.swift
//  instagram
//
//  Created by 서원지 on 2022/06/01.
//

import Firebase

struct Comment {
    let uid: String
    let username: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let commentText: String
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? UserText.wrongInput
        self.username = dictionary["username"] as? String ?? UserText.wrongInput
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? UserText.wrongInput
        self.commentText = dictionary["comment"] as? String ?? UserText.wrongInput
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date( ))
    }
}
