//
//  Post.swift
//  InstagramClone
//
//  Created by nandawperdana on 24/07/24.
//

import FirebaseFirestoreInternal

struct Post {
    let postId: String
    var caption: String
    let imageUrl: String
    var likes: Int
    let ownerUid: String
    let timestamp: Timestamp
    
    init(postId: String, dictionary: [String: Any]) {
        self.postId = postId
        self.caption = dictionary["caption"] as? String ?? ""
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.ownerUid = dictionary["ownerUid"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
}
