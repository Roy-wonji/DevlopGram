//
//  PostService.swift
//  instagram
//
//  Created by 서원지 on 2022/05/26.
//

import UIKit
import Firebase

struct PostService {
    
    static func  uploadPost(caption: String, image: UIImage, completion: @escaping (FirestoreCompletion) ) {
        guard let uid  = Auth.auth().currentUser?.uid  else { return }
        
        ImageUploader.uploadImage(image: image) { imageUrl in
            let data  = [ "caption" : caption,
                          "timestamp" : Timestamp(date: Date()),
                          "likes":  0 ,
                          "imageUrl": imageUrl,
                          "ownerUid": uid ] as [String : Any]
            
            Constants.COLLECTION_POST.addDocument(data: data, completion: completion)
        }
    }
}

