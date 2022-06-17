//
//  NotificationViewModel.swift
//  instagram
//
//  Created by 서원지 on 2022/06/16.
//

import UIKit

struct NotificationViewModel {
    var notification: Notification
    
    var postImageurl: URL? { return URL(string: notification.postImageUrl ?? UserText.wrongInput) }
    var profileImageUrl: URL? { return URL(string: notification.userProfileImageUrl) }
    var notificationMessage: NSAttributedString {
        let userName = notification.userName
        let message = notification.type.description
        let attributedText = NSMutableAttributedString(string: userName,
                                                       attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: message,
                                                 attributes: [.font: UIFont.systemFont(ofSize: 14)] ))
        attributedText.append(NSAttributedString(string: "   2m",
                                                 attributes: [.font: UIFont.systemFont(ofSize: 12),
                                                              .foregroundColor: UIColor.lightGray] ))
        return attributedText
    }
    
    var shouldHidePostImage: Bool { return self.notification.type == .follow }
    
    var followButtonText: String {
        return notification.userIsFollowed ? "팔로잉" : "팔로우"
    }
    
    var followButtonBackground: UIColor {
        return notification.userIsFollowed ? .white : .systemBlue
    }
    
    var followButtonTextColor: UIColor? {
        return notification.userIsFollowed ? .buttonColorAsset : .white
    }
    
    init(notification: Notification) {
        self.notification = notification
    }
}
