//
//  User.swift
//  instagram
//
//  Created by 서원지 on 2022/05/08.
//

import Foundation

struct User {
    let email: String
    let fullname: String
    let profileImageUrl: String
    let username: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? UserText.wrongInput
        self.fullname = dictionary["fullname"] as? String  ?? UserText.wrongInput
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? UserText.wrongInput
        self.username = dictionary["username"] as? String ?? UserText.wrongInput
        self.uid = dictionary["uid"] as? String ?? UserText.wrongInput
    }
}
