//
//  AuthService.swift
//  InstagramClone
//
//  Created by nandawperdana on 17/07/24.
//

import UIKit

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
    
    func registerUser(withCredential credential: AuthCredential) {
        print("credential: \(credential)")
    }
}
