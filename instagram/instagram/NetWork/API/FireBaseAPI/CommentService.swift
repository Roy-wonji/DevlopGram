//
//  CommentService.swift
//  instagram
//
//  Created by 서원지 on 2022/06/01.
//

import Firebase

struct CommentService {
    
    static func uploadComment(comment: String, postID: String, user: User,
    completion: @escaping(FirestoreCompletion)) {
        
        let data : [String: Any] = ["uid" : user.uid,
                                    "comment" : comment,
                                    "timestamp": Timestamp(date: Date( ) ),
                                    "username": user.username,
                                    "profileImage" : user.profileImageUrl ]
        
        Constants.COLLECTION_POSTS.document(postID).collection("comments").addDocument(data: data, 
                                                                                       completion: completion)
        
        
    }
    
    static func fetchComments() {
        
    }
    
}
