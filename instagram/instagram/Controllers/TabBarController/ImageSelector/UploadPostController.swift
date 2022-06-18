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
    var selectedImage: UIImage? {
        didSet {uploadView.photoImageVIew.image = selectedImage }
    }
    
    weak var delegate: UploadPostControllerDelegate?
    var currentUser: User?
    
    //MARK: - Lifecycle
    private let uploadView = UploadView()
    
    override func loadView() {
        view = uploadView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Actions
    @objc func didTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapDone() {
        DispatchQueue.main.async {
            guard let image = self.selectedImage else { return }
            guard let caption = self.uploadView.captionTextView.text else { return }
            guard let user = self.currentUser else { return }
            self.showLoader(true)
            PostService.uploadPost(caption: caption, image: image, user: user) { error  in
                self.showLoader(false)
                self.dismiss(animated: true, completion: PushNotification.postPushNotification)
                if let error = error {
                    print("DEBUG: Failed to upload post with error \(error.localizedDescription)")
                    return
                }
                self.delegate?.controllerDidFinishUploadingPost(self)
            }
        }
    }
    
    //MARK:  - UI 관련
    private func configureUI() {
        navigationItemUI()
        view.backgroundColor = .backgroundColor
        tabBarController?.tabBar.barTintColor = .backgroundColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textColorAsset ?? UserText.wrongInput]
    }
    
    private func navigationItemUI() {
        navigationItem.title = UploadImageText.leftnavigationBarTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(didTapCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: UploadImageText.rightnavigationBarTitle, style: .done, target: self, action: #selector(didTapDone))
    }
}

