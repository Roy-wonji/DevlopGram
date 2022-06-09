//
//  FeedCellDelegate.swift
//  instagram
//
//  Created by 서원지 on 2022/05/31.
//

import Foundation

protocol FeedCellDelegate: AnyObject {
    func cell(_ cell: FeedCell, wantsToShowCommentsFor  post: Post)
    func cell(_ cell: FeedCell, didLike post: Post)
}
