//
//  LoginController.swift
//  InstagramClone
//
//  Created by nandawperdana on 15/07/24.
//

import UIKit

class LoginController: UIViewController {
    
    // MARK: Properties
    private var viewModel = LoginViewModel()
    
    private let iconImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "ic_logo"))
        iv.contentMode = .scaleAspectFill
        return iv
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
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue.withAlphaComponent(0.5)
        button.layer.cornerRadius = 10
        button.setHeight(40)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.isEnabled = false
        button.addTarget(self, action: #selector(onTapLogin), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributedTitle(firstPart: "Don't have and account? ", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(onTapRegister), for: .touchUpInside)
        return button
    }()
    
    private let leftLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.systemGray
        line.setDimensions(height: 1, width: 132)
        return line
    }()
    
    private let rightLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.systemGray
        line.setDimensions(height: 1, width: 132)
        return line
    }()
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.textColor = UIColor.systemGray
        return label
    }()
    
    private let appleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue with Apple", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setHeight(40)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(onTapLoginApple), for: .touchUpInside)
        return button
    }()
    
    private let googleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue with Google", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.setHeight(40)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(onTapLoginGoogle), for: .touchUpInside)
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
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 30, width: 100)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 40)
        
        let divStack = UIStackView(arrangedSubviews: [leftLine, orLabel, rightLine])
        divStack.axis = .horizontal
        divStack.spacing = 8
        divStack.alignment = .center
        divStack.distribution = .equalCentering
        
        let stack = UIStackView (arrangedSubviews: [emailTextField, passwordTextField, loginButton, divStack, appleButton, googleButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 64, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    // MARK: Actions
    @objc func onTapLogin() {
        print("onTapLogin")
    }
    
    @objc func onTapLoginApple() {
        print("onTapLoginApple")
    }
    
    @objc func onTapLoginGoogle() {
        print("onTapLoginGoogle")
    }
    
    @objc func onTapRegister() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func onTextChanged(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        updateForm()
    }
}

extension LoginController: FormViewModel {
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.isEnabled = viewModel.isValidForm
    }
}
