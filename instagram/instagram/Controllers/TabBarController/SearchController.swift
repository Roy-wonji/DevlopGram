//
//  SearchController.swift
//  instagram
//
//  Created by 서원지 on 2022/04/27.
//

import UIKit

final class SearchController:  UITableViewController {
    //MARK: - Properties
    
    //MARK:  - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
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
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.searchReuseIdentifier, for:  indexPath)
        cell.backgroundColor = .backgroundColor
        return cell
    }
}


