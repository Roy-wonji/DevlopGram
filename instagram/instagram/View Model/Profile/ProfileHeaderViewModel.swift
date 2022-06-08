//
//  ProfileHeaderViewModel.swift
//  instagram
//
//  Created by 서원지 on 2022/05/08.
//

import UIKit

struct ProfileHeaderViewModel {
    let user: User
    
    var fullname: String {
        return user.fullname
    }
    
    var profileImageUrl:  URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var followedButtonText: String  {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        return user.isFollowed  ? "Follwing" : "Follow"
    }
    
    var followedButtonBackgroundColor: UIColor? {
        return user.isCurrentUser ? .backgroundColorAsset :  .backgroundColorAsset
    }
    
    var followedButtonTextColor: UIColor? {
        return user.isCurrentUser ? .textColorAsset  :  .textColorAsset
    }
    
    var numberOfFollowers: NSAttributedString {
        return attributedStatText(value: user.stats.followers, label: ProfileUIText.followerLabelText)
    }
    
    var numberOfFollowing: NSAttributedString {
        return attributedStatText(value: user.stats.following, label: ProfileUIText.followingLabelText)
    }
    
    var numberOfPosts: NSAttributedString {
        return attributedStatText(value: user.stats.posts, label: ProfileUIText.postLabelText)
    }
    
    var isFollwed: Bool {
        return user.isFollowed
    }
    
    init(user: User) {
        self.user = user
    }
    
    func attributedStatText(value: Int, label: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: label, attributes:  [.font: UIFont.boldSystemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        return attributedText
    }
}
