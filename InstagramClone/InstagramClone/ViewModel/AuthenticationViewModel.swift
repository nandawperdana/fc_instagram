//
//  AuthenticationViewModel.swift
//  InstagramClone
//
//  Created by nandawperdana on 16/07/24.
//

import UIKit

struct LoginViewModel {
    var email: String?
    var password: String?
    
    var isValidForm: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return isValidForm ? UIColor.systemBlue : UIColor.systemBlue.withAlphaComponent(0.5)
    }
}


struct RegistrationViewModel {
    var email: String?
    var password: String?
    
    var isValidForm: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
