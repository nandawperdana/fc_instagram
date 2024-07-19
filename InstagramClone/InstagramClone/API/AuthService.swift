//
//  AuthService.swift
//  InstagramClone
//
//  Created by nandawperdana on 17/07/24.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

struct AuthCredentials {
    let email: String
    let password: String?
    let fullname: String
    let username: String
    let profileImage: UIImage?
    let profileImageUrl: String?
}

class AuthService {
    static let shared = AuthService()
    
    private init() { }
    
    func registerUser(withCredential credential: AuthCredentials, completion: @escaping(Error?) -> Void) {
        guard let password = credential.password else { return }
        guard let profileImage = credential.profileImage else { return }
        
        ImageUploaderService.shared.uploadImage(image: profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credential.email, password: password) { result, error in
                if let error = error {
                    print("DEBUG: Failed to create user \(error.localizedDescription)")
                    return
                }
                
                guard let id = result?.user.uid else { return }
                
                let data: [String: Any] = ["email": credential.email, "fullname": credential.fullname, "profileImage": imageUrl, "uid": id, "username": credential.username]
                
                FirebaseReference.getReference(.User).document(id).setData(data, completion: completion)
            }
        }
    }
    
    func registerGoogleUser(withCredential credential: AuthCredential) {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print("DEBUG: Failed to Sign Out \(error.localizedDescription)")
        }
            
        Auth.auth().signIn(with: credential) { result, error in
            if let error = error {
                print("DEBUG: Failed to Sign In with Google \(error.localizedDescription)")
                return
            }
            
            let gCurrentUser = GIDSignIn.sharedInstance.currentUser
            guard let uid = result?.user.uid else { return }
            guard let profile = gCurrentUser?.profile else { return }
            
            let data: [String: Any] = ["email": profile.email, "fullname": profile.name, "profileImage": profile.imageURL(withDimension: 200)?.absoluteString ?? "", "uid": uid, "username": extractUsername(from: profile.email) ?? profile.email]
            
            FirebaseReference.getReference(.User).document(uid).setData(data, completion: nil)
        }
    }
}
