//
//  AuthService.swift
//  instagram
//
//  Created by 서원지 on 2022/05/01.
//

import Foundation
import Firebase

struct AuthService {
    static func logUseIn(withEmail email: String, password: String, completion:   @escaping(AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func registerUser(withCredential credentials: AuthCredentials,  completion:
                             @escaping(Error?) -> Void) {
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result,  error) in
                
                if let error = error {
                    print("DEBUG: Falied to register user \(error.localizedDescription)")
                    return
                }
                guard let uid = result?.user.uid else { return }
                
                let data: [String: Any] = ["email": credentials.email,
                                           "fullname": credentials.fullname ,
                                           "profileImageUrl": imageUrl,
                                           "uid": uid,
                                           "username": credentials.username]
                Constants.COLLECTION_USERS.document(uid).setData(data, completion: completion)
            }
        }
    }
}
