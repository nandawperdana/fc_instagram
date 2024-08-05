//
//  UserCellViewModel.swift
//  InstagramClone
//
//  Created by nandawperdana on 21/07/24.
//

import Foundation

struct UserCellViewModel {
    private let user: User
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImage)
    }
    
    var fullname: String {
        return user.fullname
    }
    
    var username: String {
        return user.username
    }
    
    init(user: User) {
        self.user = user
    }
}
