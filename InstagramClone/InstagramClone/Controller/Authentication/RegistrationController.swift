//
//  RegistrationController.swift
//  InstagramClone
//
//  Created by nandawperdana on 15/07/24.
//

import UIKit

class RegistrationController: UIViewController {
    // MARK: Properties
    private let photoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(onTapPhoto), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholder: "email")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let fullNameTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Full Name")
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    private let userNameTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Username")
        tf.keyboardType = .default
        return tf
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue.withAlphaComponent(0.5)
        button.layer.cornerRadius = 10
        button.setHeight(40)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.isEnabled = true
        button.addTarget(self, action: #selector(onTapSignUp), for: .touchUpInside)
        return button
    }()
    
    private let alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Already have an account? ", secondPart: "Log In")
        button.addTarget(self, action: #selector(onTapLogin), for: .touchUpInside)
        return button
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: Config UI
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(photoButton)
        photoButton.centerX(inView: view)
        photoButton.setDimensions(height: 98, width: 98)
        photoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView (arrangedSubviews: [emailTextField, passwordTextField, fullNameTextField, userNameTextField, signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: photoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 64, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    // MARK: Actions
    @objc func onTapPhoto() {
        print("onTapPhoto")
    }
    
    @objc func onTapSignUp() {
        print("onTapSignUp")
    }
    
    @objc func onTapLogin() {
        navigationController?.popViewController(animated: true)
    }
}
