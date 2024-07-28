//
//  PostViewModel.swift
//  InstagramClone
//
//  Created by nandawperdana on 24/07/24.
//

import UIKit

struct PostViewModel {
    var post: Post
    
    var profileImageUrl: URL? {
        return URL(string: post.ownerProfileImage)
    }
    
    var username: String {
        return post.ownerUsername
    }
    
    var imageUrl: URL? {
        return URL(string: post.imageUrl)
    }
    
    var caption: String {
        return post.caption
    }
    
    var likes: Int {
        return post.likes
    }
    
    var likesText: String {
        if post.likes != 1 {
            return "\(likes) likes"
        } else {
            return "\(likes) like"
        }
    }
    
    var likeButtonTintColor: UIColor {
        return post.didLike ? .red : .black
    }
    
    var likeButtonImage: UIImage? {
        let image = post.didLike ? "heart.fill" : "heart"
        return UIImage(systemName: image)
    }
    
    var timestampText: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        return formatter.string(from: post.timestamp.dateValue(), to: Date())
    }
    
    init(post: Post) {
        self.post = post
    }
}
