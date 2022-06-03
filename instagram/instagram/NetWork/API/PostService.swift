//
//  PostService.swift
//  instagram
//
//  Created by 서원지 on 2022/05/26.
//

import UIKit
import Firebase

struct PostService {
    
    static func  uploadPost(caption: String, image: UIImage, user: User,
                            completion: @escaping (FirestoreCompletion) ) {
        guard let uid  = Auth.auth().currentUser?.uid  else { return }
        
        ImageUploader.uploadImage(image: image) { imageUrl in
            let data  = [ "caption" : caption,
                          "timestamp" : Timestamp(date: Date()),
                          "likes":  0 ,
                          "imageUrl": imageUrl,
                          "ownerUid": uid ,
                          "ownerImageUrl": user.profileImageUrl,
                          "ownerUsername": user.username] as [String : Any]
            
            Constants.COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
    
    static func fetchPosts(completion: @escaping([Post]) -> Void) {
        Constants.COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            
            let posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            completion(posts)
        }
    }
    
    static func fetchPost(forUser uid: String, completion: @escaping([Post]) -> Void) {
        let query = Constants.COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid)
        
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            
            var posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            posts.sort { (fristPost, secondPost)  in
                return fristPost.timestamp.seconds > secondPost.timestamp.seconds
            }
            completion(posts)
        }
    }
    
    static func likePost(post: Post, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Constants.COLLECTION_POSTS.document(post.postId).updateData(["likes": post.likes + 1])
        Constants.COLLECTION_POSTS.document(post.postId).collection("post-likes").document(uid)
            .setData([ : ]) { _ in
                Constants.COLLECTION_POSTS.document(uid).collection("user-likes").document(post.postId).setData([ : ], completion: completion)
            }
    }
    
    static func unlikePost() {
        
    }
}
