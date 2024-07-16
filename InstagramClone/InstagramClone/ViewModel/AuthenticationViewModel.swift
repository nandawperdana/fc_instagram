//
//  AuthenticationViewModel.swift
//  InstagramClone
//
//  Created by nandawperdana on 16/07/24.
//

import UIKit

protocol FormViewModel {
    func updateForm()
}

protocol AuthenticationViewModel {
    var isValidForm: Bool { get }
    var buttonBackgroundColor: UIColor { get }
}

struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    
    var isValidForm: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return isValidForm ? UIColor.systemBlue : UIColor.systemBlue.withAlphaComponent(0.5)
    }
}


struct RegistrationViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    var fullName: String?
    var username: String?
    
    var isValidForm: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && fullName?.isEmpty == false && username?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return isValidForm ? UIColor.systemBlue : UIColor.systemBlue.withAlphaComponent(0.5)
    }
}
