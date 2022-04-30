//
//  RegistrationController.swift
//  instagram
//
//  Created by 서원지 on 2022/04/29.
//

import UIKit
import Then

final class RegistrationController: UIViewController {
    //MARK:  - Properties
    private var viewModel = RegistrationViewModel()
    
    private lazy var plusPhotoButton = UIButton(type: .system).then{ button  in
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
    }
    
    private lazy var emailTextField = CustomTextField(placeholder: RegisterUIText.emailTextFieldText).then { textField  in
        textField.keyboardType = .emailAddress
    }
    
    private lazy var passwordTextField = CustomTextField(placeholder: RegisterUIText.passwordTextFieldText).then { textField  in
        textField.isSecureTextEntry = true
    }
    
    private lazy var fullNameTextField = CustomTextField(placeholder: RegisterUIText.fullNameTextFieldText)
    private lazy var userNameTextField = CustomTextField(placeholder: RegisterUIText.userNameTextFieldText)
    
    private lazy var signUpButton = UIButton(type: .system).then { button  in
        button.setTitle(RegisterUIText.signUpButtonText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private lazy var alreadyHaveAccountButton = UIButton(type: .system).then { button in
        button.attributedTitle(fristPart: RegisterUIText.alreadyHaveAccountButtonText,
                               secondPart: RegisterUIText.signUpButtonText)
       button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK:  - Actions
    @objc func handleShowSignUp() {
        navigationController?.popViewController(animated: true)
    }
     
    @objc fileprivate func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        } else if sender == fullNameTextField {
            viewModel.fullName = sender.text
        } else {
            viewModel.userName = sender.text
        }
    }
    
    //MARK: -  UI 관련
    private func configureUI() {
       configureGradientLayer()
        setConstrants()
    }
    //MARK: 오토레이아웃 관련
    private func setConstrants() {
        setConstrantsPlusPhotoButton()
        setConstrantsStackVIew()
        setConstrantsalreadyHaveAccountButton()
    }
    
    private func setConstrantsPlusPhotoButton() {
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 140, width: 140)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
    }
    
    private func setConstrantsStackVIew() {
        let stack = UIStackView(arrangedSubviews: [ emailTextField, passwordTextField,
                                                    fullNameTextField, userNameTextField, signUpButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor,
                     right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
    }
    
    private func setConstrantsalreadyHaveAccountButton() {
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.centerX(inView: view)
        alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    private func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        userNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}


