//
//  ProfileHeaderDelegate.swift
//  instagram
//
//  Created by 서원지 on 2022/05/14.
//

import Foundation

protocol ProfileHeaderDelegate:  AnyObject {
    func header(_ profileHeader: ProfileHeader, didTapActionButton user: User)
}
