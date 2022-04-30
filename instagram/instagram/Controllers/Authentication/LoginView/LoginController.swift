//
//  LoginController.swift
//  instagram
//
//  Created by 서원지 on 2022/04/29.
//

import UIKit
import Then

final class LoginController: UIViewController {
    //MARK:  - Properties
    
    
    private let iconImage = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white")).then { imageView in
        imageView.contentMode = .scaleAspectFill
    }
    
    private lazy var emailTextField = CustomTextField(placeholder: LoginUiText.emailTextFieldText).then { textField  in
        textField.keyboardType = .emailAddress
    }
    
    private lazy var passwordTextField = CustomTextField(placeholder: LoginUiText.passwordTextFieldText).then { textField  in
        textField.isSecureTextEntry = true
    }
    
    private lazy var loginButton = UIButton(type: .system).then { button  in
        button.setTitle(LoginUiText.loginText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    private lazy var forgotPasswordButton = UIButton(type: .system).then { button in
        button.attributedTitle(fristPart: LoginUiText.passwordAttributedTitleText, secondPart: LoginUiText.helpSignText)
    }

    private lazy var dontHaveAccountButton = UIButton(type: .system).then { button in
        button.attributedTitle(fristPart: LoginUiText.attributedTitleText, secondPart: LoginUiText.signupText)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstrants()
    }
    
    //MARK: - Actions
    @objc fileprivate func handleShowSignUp() {
        let controller  = RegistrationController()
     navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK: -  UI 관련
    private func configureUI() {
       configureGradientLayer()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    //MARK: - 오토레이아웃
    private func setConstrants() {
        setConstrantsIconImage()
        setConstrantsStackVIew()
        setConstrantsDontHaveAccountButton()
    }
    
    private func setConstrantsIconImage() {
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
    }
    
    private func setConstrantsStackVIew() {
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgotPasswordButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor,
                     right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
    }
    
    private func setConstrantsDontHaveAccountButton() {
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.centerX(inView: view)
        dontHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
}
