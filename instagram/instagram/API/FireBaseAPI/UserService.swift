//
//  UserService.swift
//  instagram
//
//  Created by 서원지 on 2022/05/08.
//

import Firebase
import UIKit
import FirebaseFirestore

struct UserService {
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            print("\(String(describing: snapshot?.data()))")
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    //MARK: - firebase 에서 사용자 정보 받아 오기
    static func fetchUsers(completion: @escaping ([User]) -> Void) {
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            
            let users = snapshot.documents.map({ User (dictionary: $0.data() )  })
            completion(users)
        }
    }
}
