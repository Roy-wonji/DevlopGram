//
//  CommentInputAcessoryViewDelegate.swift
//  instagram
//
//  Created by 서원지 on 2022/06/01.
//

import Foundation

protocol CommentInputAcessoryViewDelegate: AnyObject {
    func inputView(_ inputView: CommentInputAcessoryView, wnantTouploadComment comment: String)
}
