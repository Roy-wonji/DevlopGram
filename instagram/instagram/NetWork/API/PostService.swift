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
            let documentRefenernce = FireBaseData.COLLECTION_POSTS.addDocument(data: data, completion: completion)
            
               updateUserFeedAfterPost(postId: documentRefenernce.documentID)
        }
    }
    
    static func fetchPosts(completion: @escaping([Post]) -> Void) {
        FireBaseData.COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            let posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            completion(posts)
        }
    }
    
    static func fetchPost(forUser uid: String, completion: @escaping([Post]) -> Void) {
        let query = FireBaseData.COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid)
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            var posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            posts.sort { (fristPost, secondPost)  in
                return fristPost.timestamp.seconds > secondPost.timestamp.seconds
            }
            completion(posts)
        }
    }
    
    static func fetchPost(withPostId postId: String, completion: @escaping(Post) -> Void) {
        FireBaseData.COLLECTION_POSTS.document(postId).getDocument { snapshot, _  in
            guard let snapshot = snapshot else { return }
            guard let data = snapshot.data()  else { return }
            let post = Post(postId: snapshot.documentID, dictionary: data)
            completion(post)
        }
    }
    //MARK:  포스트에 좋아요 눌른 함수
    static func likePost(post: Post, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        FireBaseData.COLLECTION_POSTS.document(post.postId).updateData(["likes": post.likes + 1])
        FireBaseData.COLLECTION_POSTS.document(post.postId).collection("post-likes").document(uid)
            .setData(FollowUser.postLikeUserSetData) { _ in
                FireBaseData.COLLECTION_POSTS.document(uid).collection("user-likes").document(post.postId).setData([ : ], completion: completion)
            }
    }
    //MARK: 포스트에 좋아요 안눌른 함수
    static func unlikePost(post: Post, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard post.likes > .zero else { return }
        FireBaseData.COLLECTION_POSTS.document(post.postId).updateData(["likes" : post.likes - 1])
        FireBaseData.COLLECTION_POSTS.document(post.postId).collection("post-likes").document(uid).delete { _ in
            FireBaseData.COLLECTION_USERS.document(uid).collection("user-likes").document(post.postId).delete(completion: completion)
        }
    }
    
    static func checkIfUserLikedPost(post: Post, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        FireBaseData.COLLECTION_USERS.document(uid).collection("user-likes").document(post.postId).getDocument { (snapshot, error) in
            guard let didLike = snapshot?.exists else { return }
            completion(didLike)
        }
    }
    
    static func fetchFeedPost(completion: @escaping([Post]) -> Void) {
        guard let uid  = Auth.auth().currentUser?.uid  else { return }
        var posts = [Post]()
        
        FireBaseData.COLLECTION_USERS.document(uid).collection("user-feed").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                fetchPost(withPostId: document.documentID) { post in
                    posts.append(post)
                    completion(posts)
                }
            })
        }
    }
    
    static func updateUserFeedAfterFollowing(user: User, didFollow: Bool) {
        guard let uid  = Auth.auth().currentUser?.uid else { return }
        let query = FireBaseData.COLLECTION_POSTS.whereField("ownerUid", isEqualTo: user.uid)
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            let docementId = documents.map({ $0.documentID })
            docementId.forEach { id in
                if didFollow {
                    FireBaseData.COLLECTION_USERS.document(uid).collection("user-feed").document(id)
                        .setData(FollowUser.updateUserFeedSetData)
                } else {
                    FireBaseData.COLLECTION_USERS.document(uid).collection("user-feed").document(id).delete()
                }
            }
        }
    }
}

private func updateUserFeedAfterPost(postId: String) {
    guard let uid  = Auth.auth().currentUser?.uid else { return }
    FireBaseData.COLLECTION_FOLLOWERS.document(uid).collection("user-followes").getDocuments { snapshot, _ in
        guard let document = snapshot?.documents else {return}
        document.forEach { document in
            FireBaseData.COLLECTION_USERS.document(document.documentID).collection("user-feed").document(postId).setData(FollowUser.updateUserFeedSetData)
        }
        FireBaseData.COLLECTION_USERS.document(uid).collection("user-feed").document(postId).setData(FollowUser.updateUserFeedSetData)
    }
}
