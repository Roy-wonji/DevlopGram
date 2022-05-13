//
//  UserService.swift
//  instagram
//
//  Created by 서원지 on 2022/05/08.
//

import Firebase
import UIKit

typealias FirestoreCompletion = (Error?) -> Void

struct UserService {
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Constants.COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            //            print("\(String(describing: snapshot?.data()))")
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    //MARK: - firebase 에서 사용자 정보 받아 오기
    static func fetchUsers(completion: @escaping ([User]) -> Void) {
        Constants.COLLECTION_USERS.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            
            let users = snapshot.documents.map({ User (dictionary: $0.data() )  })
            completion(users)
        }
    }
    
    //MARK: - firebase에서 팔로우 하는 사람과 팔로잉
    static func followUser(uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Constants.COLLECTION_FOLLOWERING.document(currentUid).collection("user-following").document(uid).setData(FollowUser.followingUserSetData) { error in
            Constants.COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData(FollowUser.followerUserSetData, completion: completion)
        }
    }
    //MARK: - firebase에서 언팔로우
    static func unfollowUser(uid: String, completion: @escaping(FirestoreCompletion) ) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        Constants.COLLECTION_FOLLOWERING.document(currentUid).collection("user-following").document(uid).delete { error in
            Constants.COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
        }
    }
}
