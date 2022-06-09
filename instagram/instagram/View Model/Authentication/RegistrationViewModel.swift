//
//  RegistrationViewModel.swift
//  instagram
//
//  Created by 서원지 on 2022/04/30.
//

import UIKit

struct RegistrationViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    var fullName: String?
    var userName: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false  &&  password?.isEmpty == false
        && fullName?.isEmpty == false  && userName?.isEmpty == false
    }
    
    var buttonBackground: UIColor {
        return formIsValid ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    var buttonTitleColor: UIColor {
        return  formIsValid ? .white  : UIColor(white: 1, alpha: 0.67)
    }
    
}
