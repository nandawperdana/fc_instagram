//
//  NotificationViewModel.swift
//  InstagramClone
//
//  Created by nandawperdana on 02/08/24.
//

import UIKit

struct NotificationViewModel {
    var notification: Notification
    
    init(notification: Notification) {
        self.notification = notification
    }
    
    var postImageUrl: URL? { return URL(string: notification.postImage ?? "") }
    
    var profileImageUrl: URL? { return URL(string: notification.profileImage ?? "") }
    
    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notification.timestamp.dateValue(), to: Date())
    }
    
    var notificationMessage: NSAttributedString {
        let username = notification.username
        let message = notification.type.message
        
        let attributedText = NSMutableAttributedString(string: username, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: message, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        attributedText.append(NSAttributedString(string: " \(timestampString ?? "")", attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: UIColor.lightGray]))
        
        return attributedText
    }
    
    var shouldHidePostImage: Bool { return notification.type == .follow }
    
    var followButtonText: String {
        return notification.userIsFollowed ? "Unfollow" : "Follow"
    }
    
    var followButtonBackgroundColor: UIColor {
        return notification.userIsFollowed ? .white : .blue
    }
    
    var followButtonTextColor: UIColor {
        return notification.userIsFollowed ? .black : .white
    }
}
