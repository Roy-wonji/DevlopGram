//
//  Notification.swift
//  instagram
//
//  Created by 서원지 on 2022/06/10.
//

import Firebase

struct Notification  {
    let uid: String
    var postImageUrl: String?
    var postId: String?
    let timestamp: Timestamp
    let type: NotificationType
    let id: String
    let userProfileImageUrl: String
    let userName: String
    
    init(dictionary: [String: Any]) {
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.id = dictionary["id"] as? String ?? UserText.wrongInput
        self.uid = dictionary["uid"] as? String ?? UserText.wrongInput
        self.postId = dictionary["postId"] as? String ?? UserText.wrongInput
        self.postImageUrl = dictionary["postImageUrl"] as? String ?? UserText.wrongInput
        self.type = NotificationType(rawValue: dictionary["type"] as? Int ?? .zero) ?? .like
        self.userProfileImageUrl = dictionary["userProfileImageUrl"] as? String ?? UserText.wrongInput
        self.userName = dictionary["userName"] as? String ?? UserText.wrongInput
    }
}
