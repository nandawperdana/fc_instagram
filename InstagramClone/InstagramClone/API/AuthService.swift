//
//  AuthService.swift
//  InstagramClone
//
//  Created by nandawperdana on 17/07/24.
//

import UIKit
import FirebaseAuth

struct AuthCredential {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

class AuthService {
    static let shared = AuthService()
    
    private init() { }
    
    func registerUser(withCredential credential: AuthCredential, completion: @escaping(Error?) -> Void) {
        print("credential: \(credential)")
        Auth.auth().createUser(withEmail: credential.email, password: credential.password) { result, error in
            if let error = error {
                print("DEBUG: Failed to create user \(error.localizedDescription)")
                return
            }
            
            guard let id = result?.user.uid else { return }
            
            var data: [String: Any] = ["email": credential.email, "fullname": credential.fullname, "avatar": "", "uid": id, "username": credential.username]
            
            FirebaseReference.getReference(.User).document(id).setData(data, completion: completion)
        }
    }
}
