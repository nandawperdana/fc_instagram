//
//  NotificationService.swift
//  InstagramClone
//
//  Created by nandawperdana on 29/07/24.
//

import FirebaseFirestore
import FirebaseAuth

class NotificationService {
    
    static let shared = NotificationService()
    
    private init() { }
    
    func addNotification(toUid uid: String, fromUser: User, type: NotificationType, post: Post? = nil) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard uid != currentUid else { return }
        
        let docRef = FirebaseReference.getReference(.Notification).document(uid).collection("user-notifications").document()
        
        var data: [String: Any] = ["timestamp": Timestamp(date: Date()), "uid": fromUser.uid, "id": docRef.documentID, "type": type.rawValue, "profileImage": fromUser.profileImage, "username": fromUser.username]
        
        if let post = post {
            data["postId"] = post.postId
            data["postImage"] = post.imageUrl
        }
        
        docRef.setData(data)
    }
}
