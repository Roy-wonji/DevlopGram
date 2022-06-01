//
//  AuthenticationViewModelProtcool.swift
//  instagram
//
//  Created by 서원지 on 2022/04/30.
//

import UIKit

protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
    var buttonBackground: UIColor { get }
    var buttonTitleColor: UIColor { get }
}
