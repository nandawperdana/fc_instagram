//
//  PostService.swift
//  InstagramClone
//
//  Created by nandawperdana on 24/07/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestoreInternal

class PostService {
    static let shared = PostService()
    
    private init() { }
    
    func postAnImage(caption: String, image: UIImage, user: User, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploaderService.shared.uploadImage(image: image) { imageUrl in
            let data = ["caption": caption, "timestamp": Timestamp(date: Date()), "likes": 0, "imageUrl": imageUrl, "ownerUid": uid, "ownerUsername": user.username, "ownerProfileImage": user.profileImage] as [String: Any]
            
            FirebaseReference.getReference(.Post).addDocument(data: data, completion: completion)
        }
    }
    
    func fetchPosts(completion: @escaping([Post]) -> Void) {
        FirebaseReference.getReference(.Post).order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            let posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            completion(posts)
        }
    }
    
    func fetchPosts(forUser uid: String, completion: @escaping([Post]) -> Void) {
        let query = FirebaseReference.getReference(.Post).whereField("ownerUid", isEqualTo: uid)
        
        query.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            var posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            posts.sort(by: { $0.timestamp.seconds > $1.timestamp.seconds })
            
            completion(posts)
        }
    }
    
    func likePost(post: Post, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // Update likes counter increment +1
        FirebaseReference.getReference(.Post).document(post.postId).updateData(["likes": post.likes + 1])
        print("post likes: \(post.likes)")
        
        // Add new collection to Post
        FirebaseReference.getReference(.Post).document(post.postId).collection("likes").document(uid).setData([:]) { _ in
            // Add new collection to User
            FirebaseReference.getReference(.User).document(uid).collection("likes").document(post.postId).setData([:], completion: completion)
        }
    }
    
    func unlikePost(post: Post, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // Update likes counter decrement -1
        print("post likes: \(post.likes)")
//        guard post.likes > 0 else { return }
        FirebaseReference.getReference(.Post).document(post.postId).updateData(["likes": post.likes - 1])
        
        // Delete "likes" collection in Post
        FirebaseReference.getReference(.Post).document(post.postId).collection("likes").document(uid).delete { _ in
            // Delete "likes" collection in User
            FirebaseReference.getReference(.User).document(uid).collection("likes").document(post.postId).delete(completion: completion)
        }
    }
}
