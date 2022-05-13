//
//  SearchController.swift
//  instagram
//
//  Created by 서원지 on 2022/04/27.
//

import UIKit

final class SearchController:  UITableViewController {
    //MARK: - Properties
    
    private var users = [User]()
    private var fillterUsers = [User]()
    private let searchController = UISearchController(searchResultsController: nil)

    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    //MARK:  - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        DispatchQueue.main.async {
            self.configureTableView()
            self.fetchUsers()
            self.configureSearchController()
        }
    }
    
    //MARK: - API
   private  func fetchUsers() {
        UserService.fetchUsers { user in
            self.users = user
            self.tableView.reloadData()
        }
    }
    
    private func configureTableView() {
        view.backgroundColor = .backgroundColor
        tableView.register(UserCell.self, forCellReuseIdentifier: CellIdentifier.searchReuseIdentifier)
        tableView.rowHeight = 64
    }
    
   private func configureSearchController ( ) {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
}

//MARK: - UITableViewDataSource
extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? fillterUsers.count :  users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.searchReuseIdentifier, for:  indexPath) as! UserCell
        cell.backgroundColor = .backgroundColor
        let user = inSearchMode ? fillterUsers[indexPath.row] : users[indexPath.row]
        cell.viewModel = UserCellViewModel(user: user)
        return cell
    }
}
//MARK: - UITableViewDataSource
extension SearchController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG : user is \(users[indexPath.row].username)")
        let controller  = ProfileController(user: users[indexPath.row])
        navigationController?.pushViewController(controller, animated: true)
    }
}
//MARK: - UISearchResultsUpdating
extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
        fillterUsers = users.filter({ $0.username.contains(searchText) ||
            $0.fullname.lowercased().contains(searchText)
        })
        
        print("DEBUG: filltered users \(fillterUsers)")
        self.tableView.reloadData()
    }
}
