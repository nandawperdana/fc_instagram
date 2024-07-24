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
        FirebaseReference.getReference(.Post).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            
            let posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            completion(posts)
        }
    }
}
