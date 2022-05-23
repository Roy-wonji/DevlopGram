//
//  UploadPostController.swift
//  instagram
//
//  Created by 서원지 on 2022/05/23.
//

import UIKit
import Then

final class UploadPostController: UIViewController {
    
    //MARK:  - Propeties
   
    
    
    //MARK: - Lifecycle
    private let uploadView = UploadView()
    
    override func loadView() {
        view = uploadView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
//        updateView()
    }
    
    //MARK: - Actions
    @objc func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapDone() {
        print("DEBUG: Share post here ...")
    }
    
    //MARK:  - UI 관련
    
    private func configureUI() {
        navigationItemUI()
        view.backgroundColor = .backgroundColor
        tabBarController?.tabBar.barTintColor = .backgroundColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textColorAsset]
     
    }
    
    
    
    private func navigationItemUI() {
        navigationItem.title = UploadImageText.leftnavigationBarTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(didTapCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: UploadImageText.rightnavigationBarTitle, style: .done, target: self, action: #selector(didTapDone))
    }
    
}
