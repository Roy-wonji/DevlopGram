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
    
    private lazy var plusPhotoButton = UIButton(type: .system).then{ button  in
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
    }
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: -  UI 관련
    private func configureUI() {
       configureGradientLayer()
        setConstrants()
    }
    //MARK: 오토레이아웃 관련
    private func setConstrants() {
        setConstrantsPlusPhotoButton()
    }
    
    private func setConstrantsPlusPhotoButton() {
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 140, width: 140)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
    }
}
