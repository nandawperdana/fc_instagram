//
//  Notification.swift
//  InstagramClone
//
//  Created by nandawperdana on 29/07/24.
//

import Foundation
import FirebaseFirestore

enum NotificationType: Int {
    case like // 0
    case follow // 1
    case comment // 2
    
    var message: String {
        switch self {
        case .like:
            return " liked your post."
        case .follow:
            return " started following you."
        case .comment:
            return " commented on your post."
        }
    }
}

struct Notification {
    let id: String
    let uid: String
    let profileImage: String?
    let username: String
    let postId: String?
    let postImage: String?
    let type: NotificationType
    let timestamp: Timestamp
    var userIsFollowed: Bool
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.profileImage = dictionary["profileImage"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.postId = dictionary["postId"] as? String ?? ""
        self.postImage = dictionary["postImage"] as? String ?? ""
        self.type = NotificationType(rawValue: dictionary["type"] as? Int ?? 0) ?? .like
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.userIsFollowed = false
    }
}
