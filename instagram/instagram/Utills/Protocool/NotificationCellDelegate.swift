//
//  NotificationCellDelegate.swift
//  instagram
//
//  Created by 서원지 on 2022/06/17.
//

import Foundation

protocol NotificationCellDelegate: AnyObject {
    func cell (_ cell: NotificationCell, wantsToFollow uid: String)
    func cell (_ cell: NotificationCell, wantsToUnfollow uid: String)
    func cell (_ cell: NotificationCell, wantsToViewPost postId: String)
}
