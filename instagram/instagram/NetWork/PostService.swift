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
            
            Constants.COLLECTION_POST.addDocument(data: data, completion: completion)
        }
    }
    
    static func fetchPosts(completion: @escaping([Post]) -> Void) {
        Constants.COLLECTION_POST.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            
            let post = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            completion(post)
        }
    }
}
