//
//  UserService.swift
//  InstagramClone
//
//  Created by nandawperdana on 20/07/24.
//

import FirebaseFirestore
import FirebaseAuth

typealias FirestoreCompletion = (Error?) -> Void

class UserService {
    static let shared = UserService()
    
    private init() { }
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        FirebaseReference.getReference(.User).document(uid).getDocument { snapshot, error in
            guard let data = snapshot?.data() else { return }
            
            let user = User(dictionary: data)
            completion(user)
        }
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void) {
        FirebaseReference.getReference(.User).getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
            
            let users = snapshot.documents.map({ User(dictionary: $0.data()) })
            completion(users)
        }
    }
    
    func follow(uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        FirebaseReference.getReference(.Following).document(currentUid).collection("user-following").document(uid).setData([:]) { error in
            FirebaseReference.getReference(.Follower).document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
        }
    }
    
    func unFollow(uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentId = Auth.auth().currentUser?.uid else { return }
        
        FirebaseReference.getReference(.Following).document(currentId).collection("user-following").document(uid).delete { eror in
            FirebaseReference.getReference(.Follower).document(uid).collection("user-followers").document(currentId).delete(completion: completion)
        }
    }
}
