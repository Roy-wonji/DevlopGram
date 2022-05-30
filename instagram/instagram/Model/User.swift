//
//  User.swift
//  instagram
//
//  Created by 서원지 on 2022/05/08.
//

import Foundation
import Firebase

struct User {
    let email: String
    let fullname: String
    let profileImageUrl: String
    let username: String
    let uid: String
    
    var isFollowed = false
    
    var stats: UserStats!
    
    var isCurrentUser: Bool { return  Auth.auth().currentUser?.uid == uid}
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? UserText.wrongInput
        self.fullname = dictionary["fullname"] as? String  ?? UserText.wrongInput
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? UserText.wrongInput
        self.username = dictionary["username"] as? String ?? UserText.wrongInput
        self.uid = dictionary["uid"] as? String ?? UserText.wrongInput
        self.stats = UserStats(followers: .zero, following: .zero, posts: .zero)
    }
}
