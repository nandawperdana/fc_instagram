//
//  RegistrationController.swift
//  InstagramClone
//
//  Created by nandawperdana on 15/07/24.
//

import UIKit

class RegistrationController: UIViewController {
    
    // MARK: Properties
    private var viewModel = RegistrationViewModel()
    private var profileImage: UIImage?
    
    private let photoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(onTapPhoto), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField: UITextField = {
        let tf = CustomTextField(placeholder: "email")
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(onTextChanged), for: .editingChanged)
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = CustomTextField(placeholder: "password")
        tf.isSecureTextEntry = true
        tf.addTarget(self, action: #selector(onTextChanged), for: .editingChanged)
        return tf
    }()
    
    private let fullNameTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Full Name")
        tf.keyboardType = .emailAddress
        tf.addTarget(self, action: #selector(onTextChanged), for: .editingChanged)
        return tf
    }()
    
    private let userNameTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Username")
        tf.keyboardType = .default
        tf.addTarget(self, action: #selector(onTextChanged), for: .editingChanged)
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
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    @objc func onTapSignUp() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let username = userNameTextField.text else { return }
        guard let fullName = fullNameTextField.text else { return }
        guard let image = profileImage else { return }
        
        let credential = AuthCredential(email: email, password: password, fullname: fullName, username: username, profileImage: image)
        AuthService.shared.registerUser(withCredential: credential) { error in
            if let error = error {
                print("DEBUG: Failed to register user \(error.localizedDescription)")
                return
            }
            
            print("Success register")
        }
    }
    
    @objc func onTapLogin() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func onTextChanged(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        }else if sender == fullNameTextField {
            viewModel.fullName = sender.text
        }else if sender == userNameTextField {
            viewModel.username = sender.text
        }
        
        updateForm()
    }
}

// MARK: FormViewModel
extension RegistrationController: FormViewModel {
    func updateForm() {
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.isEnabled = viewModel.isValidForm
    }
}

// MARK: UIImagePickerControllerDelegate
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        profileImage = image
        
        photoButton.contentMode = .scaleAspectFit
        photoButton.clipsToBounds = true
        photoButton.layer.cornerRadius = photoButton.frame.width / 2
        photoButton.layer.masksToBounds = true
        photoButton.layer.borderColor = UIColor.blue.withAlphaComponent(0.5).cgColor
        photoButton.layer.borderWidth = 2
        photoButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
}
