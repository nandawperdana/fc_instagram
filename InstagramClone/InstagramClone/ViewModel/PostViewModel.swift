//
//  PostViewModel.swift
//  InstagramClone
//
//  Created by nandawperdana on 24/07/24.
//

import Foundation

struct PostViewModel {
    var post: Post
    
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
        return "\(likes) likes"
    }
    
    init(post: Post) {
        self.post = post
    }
}
