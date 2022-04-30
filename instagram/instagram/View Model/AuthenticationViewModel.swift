//
//  AuthenticationViewModel.swift
//  instagram
//
//  Created by 서원지 on 2022/04/30.
//

import Foundation

struct LoginVIewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false  &&  password?.isEmpty == false
    }
}
