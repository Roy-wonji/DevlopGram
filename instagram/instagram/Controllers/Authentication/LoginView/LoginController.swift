//
//  LoginController.swift
//  instagram
//
//  Created by 서원지 on 2022/04/29.
//

import UIKit
import Then
import AuthenticationServices
import Firebase
import CommonCrypto

final class LoginController: UIViewController {
    //MARK:  - Properties
    private var viewModel = LoginVIewModel()
    fileprivate var currentNonce: String?
    weak var delegate : AuthenticationDelegate?
    
    private let iconImage = UIImageView(image: UIImage(named: "Instagram_logo_white")).then { imageView in
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
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.isEnabled = false
    }
    
    private lazy var appleLoginButton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .whiteOutline).then{button in
        button.setHeight(50)
        button.clipsToBounds = true
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
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
        configureNotificationObservers()
    }
    
    //MARK: - Actions
    @objc func handleLogin() {
        guard let email = emailTextField.text else  { return }
        guard let password = passwordTextField.text else  { return }
        
        AuthService.logUseIn(withEmail: email, password: password) { (result,  error ) in
            if let error = error {
                print("DEBUG: Falied to log user in  \(error.localizedDescription)")
                return
            }
            self.delegate?.authenticationDidComplete()
        }
    }
    
    @objc func handleAuthorizationAppleIDButtonPress( ) {
        let request = createAppleIDRequest()
                let authorizationController = ASAuthorizationController(authorizationRequests: [request])
                
                authorizationController.delegate = self
                authorizationController.presentationContextProvider = self
                authorizationController.performRequests()
    }
    
    @available(iOS 13, *)
        func createAppleIDRequest() -> ASAuthorizationAppleIDRequest {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            // 애플로그인은 사용자에게서 2가지 정보를 요구함
            request.requestedScopes = [.fullName, .email]

            let nonce = randomNonceString()
            request.nonce = sha256(nonce)
            currentNonce = nonce
            
            return request
        }
    @available(iOS 13, *) // - 5️⃣
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = hashSHA256(data: inputData)
      let hashString = hashedData!.compactMap {
        return String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    
    private func hashSHA256(data:Data) -> Data? {
        var hashData = Data(count: Int(CC_SHA256_DIGEST_LENGTH))

        _ = hashData.withUnsafeMutableBytes {digestBytes in
            data.withUnsafeBytes {messageBytes in
                CC_SHA256(messageBytes, CC_LONG(data.count), digestBytes)
            }
        }
        return hashData
    }
    
    @objc fileprivate func handleShowSignUp() {
        let controller  = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc fileprivate func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        updateForm()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    //MARK: -  UI 관련
    private func configureUI() {
        configureGradientLayer()
        setConstrants()
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
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, forgotPasswordButton, appleLoginButton ])
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
    
    private func configureNotificationObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}
//MARK: - FormViewModel 확장
extension LoginController: FormViewModel {
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBackground
        loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
    }
}


// MARK: - ASAuthorizationControllerPresentationContextProviding
extension LoginController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
// MARK: - ASAuthorizationControllerDelegate
@available(iOS 13.0, *)
extension LoginController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
           
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            
            
            guard let appleIDtoken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            
            
            guard let idTokenString = String(data: appleIDtoken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDtoken.debugDescription)")
                return
            }
            
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            
            
            FirebaseAuth.Auth.auth().signIn(with: credential) { (authDataResult, error) in
                // 인증 결과에서 Firebase 사용자를 검색하고 사용자 정보를 표시할 수 있다.
                if let user = authDataResult?.user {
                    print("애플 로그인 성공!", user.uid, user.email ?? "-")
                }
                self.dismiss(animated: true, completion: nil)
                
                if error != nil {
                    print(error?.localizedDescription ?? "error" as Any)
                    return
                }
            }
        }
    }
}

extension LoginController {
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: Array<Character> =
          Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
          }
          return random
        }

        randoms.forEach { random in
          if length == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }
}
