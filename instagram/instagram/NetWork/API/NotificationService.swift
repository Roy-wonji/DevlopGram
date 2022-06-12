//
//  NotificationService.swift
//  instagram
//
//  Created by 서원지 on 2022/06/12.
//

import Firebase

struct NotificationService {
    static func uploadNotification(toUid uid: String, type: NotificationType, post: Post? = nil) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard  uid != currentUid else { return }
        let docReference = FireBaseData.COLLECTION_NOTIFICATION.document(uid).collection("user-notifcations").document()
        var data: [String: Any] = ["timestamp": Timestamp(date: Date()),
                                   "uid" : currentUid,
                                   "type": type.rawValue,
                                   "id" : docReference.documentID]
        
        if let post = post {
            data["postId"] = post.postId
            data["postImageUrl"] = post.imageUrl
        }
      
        docReference.setData(data)
    }
    
    static func fetchNotifications(completion: @escaping([Notification]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        FireBaseData.COLLECTION_NOTIFICATION.document(uid).collection("user-notifcations").getDocuments { snapshot,
            _  in
            guard let documents = snapshot?.documents else { return }
            let notificaitons = documents.map({ Notification(dictionary: $0.data()) })
            completion(notificaitons)
        }
    }
}

