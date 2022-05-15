//
//  ProfileController.swift
//  instagram
//
//  Created by 서원지 on 2022/04/27.
//

import UIKit

final class ProfileController: UICollectionViewController {
    
    //MARK: - Properties
    private var user: User
    
    //MARK: - LifeCycle
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionVIew()
        configureUI()
        updateAPI()
    }
    
    
    private func configureUI() {
        tabBarController?.tabBar.barTintColor = .backgroundColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.textColorAsset]
    }
    
    //MARK: - API
    private func updateAPI() {
        checkIfUserIsFollowed()
        fetchUserStatus()
    }
    
    private func  checkIfUserIsFollowed() {
        UserService.checkUserIsFollowed(uid: user.uid) { isFollowed in
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    
    private func fetchUserStatus() {
        UserService.fetchUserStats(uid: user.uid) { stats in
            self.user.stats = stats
            self.collectionView.reloadData()
            
            print("DEBUG: stats \(stats)")
        }
    }
    //MARK:  - UI 관련
    private func configureCollectionVIew() {
        navigationItem.title = user.username
        collectionView.backgroundColor = .backgroundColor
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: CellIdentifier.profileCellIdentifier)
        collectionView.register(ProfileHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: CellIdentifier.headerIdentifier)
    }
}

//MARK: - UICollectionViewDataSource

extension ProfileController {
    //MARK: - collectionView셀 구현
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    //MARK: - collectionView  ProfileCell 셀 등록
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.profileCellIdentifier, for: indexPath)
        return cell
    }
    //MARK: - collectionView  ProfileHeader 셀 등록
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CellIdentifier.headerIdentifier, for: indexPath) as! ProfileHeader
        header.delegate = self
        
        header.viewModel = ProfileHeaderViewModel(user: user)
        
        return header
    }
}
//MARK: - UICollectionViewDelegate
extension ProfileController {
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension ProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}
//MARK: - ProfileHeaderDelegate
extension ProfileController: ProfileHeaderDelegate {
    func header(_ profileHeader: ProfileHeader, didTapActionButton user: User) {
        if user.isCurrentUser {
            print("DEBUG: Show edit profile here")
        } else if user.isFollowed {
            UserService.unfollowUser(uid: user.uid) { error in
                self.user.isFollowed = false
                self.collectionView.reloadData()
            }
        } else {
            UserService.followUser(uid: user.uid) { error in
                self.user.isFollowed = true
                self.collectionView.reloadData()
            }
        }
    }
}
