//
//  ImageUploader.swift
//  instagram
//
//  Created by 서원지 on 2022/05/01.
//

import FirebaseStorage

struct ImageUploader {
    static func uploadImage(image: UIImage, complection:  @escaping(String)  -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else  { return }
        let filename = NSUUID().uuidString
        let repo = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        repo.putData(imageData, metadata: nil) { metadata, error  in
            if let error  = error {
                print("DEBUG: Falid to upload image \(error.localizedDescription)")
                return
            }
            
            repo.downloadURL { (url , error ) in
                guard let imageUrl = url?.absoluteString else { return }
                complection(imageUrl)
            }
        }
    }
}
