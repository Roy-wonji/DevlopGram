//
//  ProfileController.swift
//  instagram
//
//  Created by 서원지 on 2022/04/27.
//

import UIKit

final class ProfileController: UICollectionViewController {
    
    //MARK: - Properties
    var user: User? {
        didSet { collectionView.reloadData() }
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        self.overrideUserInterfaceStyle =  .light
        configureCollectionVIew()
        fetchUser()
    }
    
    //MARK: - API
    func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
            self.navigationItem.title = user.username
        }
    }
    
    //MARK:  - UI 관련
    func configureCollectionVIew() {
        collectionView.backgroundColor = .white
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
        
        print("DEBUG: Did call header functions")
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CellIdentifier.headerIdentifier, for: indexPath) as! ProfileHeader
    
        if let user = user {
            header.viewModel = ProfileHeaderViewModel(user: user)
        } else {
            print("DEBUG:  User not yet set..")
        }
        
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
