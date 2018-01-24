//
//  LoginController.swift
//  Music
//
//  Created by PAC on 9/26/17.
//  Copyright © 2017 PAC. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    lazy var createAccountTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isEditable = false
       
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        let createAccountString = NSMutableAttributedString(string: "Don't have an account? Create account", attributes: [NSForegroundColorAttributeName: StyleGuideManager.textFieldBorderColor, NSParagraphStyleAttributeName: style])
        createAccountString.addAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 15)], range: NSRange(location: 0, length: 22))
        
        let createRange = NSRange(location: 23, length: 14)
        let createAttribute = ["create": "create account", NSFontAttributeName: UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)] as [String : Any]
        createAccountString.addAttributes(createAttribute, range: createRange)
        
        textView.attributedText = createAccountString
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        textView.isUserInteractionEnabled = true
        textView.addGestureRecognizer(tap)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    lazy var forgotPasswordTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isEditable = false
        
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        
        let createAccountString = NSMutableAttributedString(string: "Forgot your password? Click here", attributes: [NSForegroundColorAttributeName: StyleGuideManager.textFieldBorderColor, NSParagraphStyleAttributeName: style])
        createAccountString.addAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 15)], range: NSRange(location: 0, length: 20))
        
        let createRange = NSRange(location: 21, length: 11)
        let createAttribute = ["password": "forgot password", NSFontAttributeName: UIFont.systemFont(ofSize: 17, weight: UIFontWeightBold)] as [String : Any]
        createAccountString.addAttributes(createAttribute, range: createRange)
        
        textView.attributedText = createAccountString
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        textView.isUserInteractionEnabled = true
        textView.addGestureRecognizer(tap)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Marimba Remix Ringtones"
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
    
    let passwordTextField: ToplessTextField = {
        
        let textField = ToplessTextField()
        let str = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: StyleGuideManager.textFieldPlaceHolderColor])
        textField.attributedPlaceholder = str
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderColor = StyleGuideManager.textFieldBorderColor
        textField.isSecureTextEntry = true
        return textField
        
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.backgroundColor = StyleGuideManager.signButtonBackgroundColor
        button.tintColor = StyleGuideManager.signButtonTintColor
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
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


//MARK: handle login
extension LoginController {
    
    @objc fileprivate func handleLogin() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}


//MARK: handle tapgesture for create account and forgot password

extension LoginController {
    
    func handleTapGesture(sender: UITapGestureRecognizer) {
        
        let textView = sender.view as! UITextView
        let layoutManager = textView.layoutManager
        
        var location = sender.location(in: textView)
        location.x -= textView.textContainerInset.left
        location.y -= textView.textContainerInset.top
        
        let characterIndex = layoutManager.characterIndex(for: location, in: textView.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        if characterIndex < textView.textStorage.length {
            // print the character index
            print("character index: \(characterIndex)")
            
            // print the character at the index
            let myRange = NSRange(location: characterIndex, length: 1)
            let substring = (textView.attributedText.string as NSString).substring(with: myRange)
            print("character at index: \(substring)")
            
            // check if the tap location has a certain attribute
            let createName = "create"
            let createValue = textView.attributedText.attribute(createName, at: characterIndex, effectiveRange: nil) as? String
            
            let passwordName = "password"
            let passwordValue = textView.attributedText.attribute(passwordName, at: characterIndex, effectiveRange: nil) as? String
            
            if let createValue = createValue {
                print("You tapped on \(createName) and the value is: \(createValue)")
                
                self.handleGoingToSignupController()
                
            } else if let passwordValue = passwordValue {
                print("You tapped on \(passwordName) and the value is: \(passwordValue)")
            }
        }
    }
    
    private func handleGoingToSignupController() {
        
        let signupController = SignupController()
        navigationController?.pushViewController(signupController, animated: true)
        
    }
    
}


//MARK: setupViews
extension LoginController {
    
    fileprivate func setupViews() {
        self.setupBackground()
        self.setupButtons()
        self.setupTextFields()
        self.setupTextViews()
    }
    
    private func setupTextViews() {
        
        view.addSubview(createAccountTextView)
        view.addSubview(forgotPasswordTextView)
        
        createAccountTextView.widthAnchor.constraint(equalToConstant: DEVICE_WIDTH).isActive = true
        createAccountTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        createAccountTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createAccountTextView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 40).isActive = true
        
        
        
        forgotPasswordTextView.widthAnchor.constraint(equalToConstant: DEVICE_WIDTH).isActive = true
        forgotPasswordTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        forgotPasswordTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        forgotPasswordTextView.topAnchor.constraint(equalTo: createAccountTextView.bottomAnchor, constant: 0).isActive = true
        
    }
    
    private func setupTextFields() {
        
        view.addSubview(passwordTextField)
        view.addSubview(emailTextField)
        view.addSubview(appNameLabel)
        
        passwordTextField.widthAnchor.constraint(equalToConstant: DEVICE_WIDTH * 0.9).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -20).isActive = true
        
        emailTextField.widthAnchor.constraint(equalToConstant: DEVICE_WIDTH * 0.9).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: 0).isActive = true
        
        appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        appNameLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        appNameLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -40).isActive = true    }
    
    private func setupButtons() {
        
        view.addSubview(loginButton)
        
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: DEVICE_WIDTH * 0.9).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        
    }
    
    private func setupBackground() {
        
        view.backgroundColor = StyleGuideManager.loginBackgroundColor
    }
    
    fileprivate func setupNavBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
}
