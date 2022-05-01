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
    private var profileImage: UIImage?
    
    private lazy var plusPhotoButton = UIButton(type: .system).then{ button  in
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleProfilePhotoSelect), for: .touchUpInside)
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
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        button.isEnabled = false
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
        configureNotificationObservers()
    }
    
    //MARK:  - Actions
    
    @objc func handleSignUp() {
        guard let email = emailTextField.text else  { return }
        guard let password = passwordTextField.text else  { return }
        guard let fullname = fullNameTextField.text else  { return }
        guard let username = userNameTextField.text else  { return }
        guard let profileImage = self.profileImage else { return }

        let crendentials = AuthCredentials(email: email, password: password,
                                         fullname: fullname, username: username,
                                         profileImage: profileImage)
        
        AuthService.registerUser(withCredential: crendentials)
    }
    
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
        updateForm()
    }
    
    @objc func handleProfilePhotoSelect() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
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
//MARK: - FormViewModel 확장
extension RegistrationController: FormViewModel {
    func updateForm() {
        signUpButton.backgroundColor = viewModel.buttonBackground
        signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        signUpButton.isEnabled = viewModel.formIsValid
    }
}
//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate 설정
extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else  { return }
        profileImage = selectedImage
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor =  UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
}
