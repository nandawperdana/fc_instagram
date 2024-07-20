//
//  User.swift
//  InstagramClone
//
//  Created by nandawperdana on 20/07/24.
//

struct User {
    let email: String
    let fullname: String
    let profileImage: String
    let username: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImage = dictionary["profileImage"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
