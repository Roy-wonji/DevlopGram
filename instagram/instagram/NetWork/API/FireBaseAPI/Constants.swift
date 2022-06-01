//
//  Constants.swift
//  instagram
//
//  Created by 서원지 on 2022/05/08.
//

import Firebase

struct Constants{
    static let COLLECTION_USERS =  Firestore.firestore().collection("users")
    static let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
    static let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
    static let COLLECTION_POSTS = Firestore.firestore().collection("posts")
}


