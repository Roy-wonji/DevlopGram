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
    
    private lazy var emailTextField = UITextField().then { textField  in
        textField.borderStyle = .none
        textField.textColor = .white
        textField.keyboardAppearance = .dark
        textField.keyboardType = .emailAddress
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.setHeight(50)
        textField.attributedPlaceholder = NSAttributedString(string: LoginUiText.emailTextFieldText , attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
    }
    
    private lazy var passwordTextField = UITextField().then { textField  in
        textField.borderStyle = .none
        textField.textColor = .white
        textField.keyboardAppearance = .dark
        textField.keyboardType = .emailAddress
        textField.backgroundColor = UIColor(white: 1, alpha: 0.1)
        textField.setHeight(50)
        textField.attributedPlaceholder = NSAttributedString(string: LoginUiText.passwordTextFieldText , attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
        textField.isSecureTextEntry = true
    }
    
    private lazy var loginButton = UIButton(type: .system).then { button  in
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstrants()
    }
    //MARK: -  UI 관련
    private func configureUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        let gradient = CAGradientLayer()
        gradient.colors = [ UIColor.systemPurple.cgColor, UIColor.systemBlue.cgColor]
        gradient.locations =  [0 , 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
    }
    
    private func setConstrants() {
        setConstrantsIconImage()
        setConstrantsStackVIew()
    }
    
    private func setConstrantsIconImage() {
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
    }
    
    private func setConstrantsStackVIew() {
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor,
                     right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
    }
}
