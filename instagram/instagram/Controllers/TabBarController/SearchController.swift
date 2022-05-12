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
    //MARK:  - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchUsers()
        
    }
    
    //MARK: - API

    func fetchUsers() {
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
}

//MARK: - UITableViewDataSource
extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.searchReuseIdentifier, for:  indexPath) as! UserCell
        cell.backgroundColor = .backgroundColor
        cell.user = users[indexPath.row]
        return cell
    }
}


