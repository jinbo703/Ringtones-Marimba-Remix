//
//  SignupController.swift
//  Music
//
//  Created by PAC on 9/26/17.
//  Copyright © 2017 PAC. All rights reserved.
//

import UIKit

class SignupController: UIViewController {
    
    let signupLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.textColor = StyleGuideManager.textFieldBorderColor
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let emailTextField: ToplessTextField = {
        
        let textField = ToplessTextField()
        let str = NSAttributedString(string: "Email Address", attributes: [NSForegroundColorAttributeName: StyleGuideManager.textFieldPlaceHolderColor])
        textField.attributedPlaceholder = str
        textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderColor = StyleGuideManager.textFieldBorderColor
        return textField
        
    }()
    
    let usernameTextField: ToplessTextField = {
        
        let textField = ToplessTextField()
        let str = NSAttributedString(string: "Username", attributes: [NSForegroundColorAttributeName: StyleGuideManager.textFieldPlaceHolderColor])
        textField.attributedPlaceholder = str
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderColor = StyleGuideManager.textFieldBorderColor
        return textField
        
    }()
    
    let passwordTextField: ToplessTextField = {
        
        let textField = ToplessTextField()
        let str = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: StyleGuideManager.textFieldPlaceHolderColor])
        textField.attributedPlaceholder = str
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderColor = StyleGuideManager.textFieldBorderColor
        textField.isSecureTextEntry = true
        return textField
        
    }()
    
    lazy var signupButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = StyleGuideManager.signButtonBackgroundColor
        button.tintColor = StyleGuideManager.signButtonTintColor
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        //        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()

    
    let backButton: UIButton = {
        
        let button = UIButton(type: .system)
        let image = UIImage(named: AssetName.backIcon.rawValue)
        button.setImage(image, for: .normal)
        button.tintColor = StyleGuideManager.buttonTintColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleDismissController), for: .touchUpInside)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupNavBar()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

//MARK: handle popup viewcontroller
extension SignupController {
    @objc fileprivate func handleDismissController() {
        
        navigationController?.popViewController(animated: true)
        
    }
}

//MARK: setup views
extension SignupController {
    
    fileprivate func setupViews() {
        self.setupBackground()
        self.setupDismissbutton()
        self.setupLabels()
        self.setupTextFields()
        self.setupButtons()
        
    }
    
    private func setupLabels() {
        view.addSubview(signupLabel)
        
        signupLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        signupLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        signupLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
    }
    
    private func setupTextFields() {
        
        view.addSubview(emailTextField)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        
        emailTextField.widthAnchor.constraint(equalToConstant: DEVICE_WIDTH * 0.9).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: signupLabel.bottomAnchor, constant: 20).isActive = true
        
        usernameTextField.widthAnchor.constraint(equalToConstant: DEVICE_WIDTH * 0.9).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 0).isActive = true
        
        passwordTextField.widthAnchor.constraint(equalToConstant: DEVICE_WIDTH * 0.9).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 0).isActive = true
        
    }
    
    private func setupButtons() {
        view.addSubview(signupButton)
        
        signupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signupButton.widthAnchor.constraint(equalToConstant: DEVICE_WIDTH * 0.9).isActive = true
        signupButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signupButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
    }
    
    private func setupDismissbutton() {
        view.addSubview(backButton)
        
        backButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
    }
    
    private func setupBackground() {
        view.backgroundColor = StyleGuideManager.loginBackgroundColor
    }
    fileprivate func setupNavBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
}
