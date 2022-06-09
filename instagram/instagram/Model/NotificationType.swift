//
//  NotificationType.swift
//  instagram
//
//  Created by 서원지 on 2022/06/10.
//

import UIKit

enum NotificationType: Int, CustomStringConvertible {
    case like
    case follow
    case comment
    
    var description: String {
        switch self {
        case .like:
            return "포스트에 좋아요가 눌렸어요 "
        case .follow:
            return "팔로우하기를 시작 했습니다"
        case .comment:
            return "게시물에 댓글을 달았어요"
        }
    }
}
