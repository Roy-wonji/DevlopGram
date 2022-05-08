//
//  FeedController.swift
//  instagram
//
//  Created by 서원지 on 2022/04/27.
//

import UIKit
import Firebase

final class FeedController:  UICollectionViewController {
    //MARK:  - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK: - UI 설정 하는 함수
    func configureUI() {
        collectionView.backgroundColor = .white
        self.overrideUserInterfaceStyle =  .light
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: CellIdentifier.resueIdentifier)
        naviagationTabBar()
    }
    
    func naviagationTabBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title:  FeedUIText.leftBarItemText, style: .plain,
            target: self, action: #selector(handleLogOut))
        navigationItem.title = "Feed"
    }
    
    //MARK: - Actions
    @objc func handleLogOut() {
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            let  navigation = UINavigationController(rootViewController: controller)
            navigation.modalPresentationStyle = .fullScreen
            self.present(navigation, animated: true, completion:  nil)
        } catch { print("DEBUG:  Falied  to  sign  out") }
    }
}



//MARK: - UICollectionViewDataSource
extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.resueIdentifier, for:  indexPath) as! FeedCell
        return cell
    }
}
//MARK:  - UICollectionViewDelegateFlowLayout
extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        return CGSize(width: width, height: height)
    }
}
