//
//  ProfileHeaderViewModel.swift
//  InstagramClone
//
//  Created by nandawperdana on 20/07/24.
//

import UIKit

struct ProfileHeaderViewModel {
    let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var fullName: String {
        return user.fullname
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImage)
    }
}
