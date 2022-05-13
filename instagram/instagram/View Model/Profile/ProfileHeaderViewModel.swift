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
        return user.isFollowed  ? "Follweing" : "Follow"
    }
    
    var followedButtonBackgroundColor: UIColor? {
        return user.isCurrentUser ? .backgroundColorAsset :  .backgroundColorAsset
    }
    
    var followedButtonTextColor: UIColor? {
        return user.isCurrentUser ? .textColorAsset  :  .textColorAsset
    }
    
    init(user: User) {
        self.user = user
    }
}
