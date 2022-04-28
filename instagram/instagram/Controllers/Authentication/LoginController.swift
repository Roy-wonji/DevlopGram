//
//  LoginController.swift
//  instagram
//
//  Created by 서원지 on 2022/04/29.
//

import UIKit

final class LoginController: UIViewController {
    //MARK:  - Properties
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        view.backgroundColor = .systemPink
    }
}