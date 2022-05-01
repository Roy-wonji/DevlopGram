//
//  AppleLoginService.swift
//  instagram
//
//  Created by 서원지 on 2022/05/01.
//

import AuthenticationServices
import Firebase



extension LoginController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
       if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
           guard let nonce = AppleLogin.currentNonce else {
           fatalError("Invalid state: A login callback was received, but no login request was sent.")
         }
         guard let appleIDToken = appleIDCredential.identityToken else {
           print("Unable to fetch identity token")
           return
         }
         guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
           print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
           return
         }
         // Initialize a Firebase credential.
         let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                   idToken: idTokenString,
                                                   rawNonce: nonce)
         // Sign in with Firebase.
         Auth.auth().signIn(with: credential) { (authResult, error) in
             if (error != nil) {
             // Error. If error.code == .MissingOrInvalidNonce, make sure
             // you're sending the SHA256-hashed nonce as a hex string with
             // your request to Apple.
                 print(error?.localizedDescription)
             return
           }
           // User is signed in to Firebase with Apple.
           // ...
         }
       }
     }

     func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
       // Handle error.
       print("Sign in with Apple errored: \(error)")
         let firebaseAuth = Auth.auth()
         do {
           try firebaseAuth.signOut()
         } catch let signOutError as NSError {
           print("Error signing out: %@", signOutError)
         }
           
     }

   }
