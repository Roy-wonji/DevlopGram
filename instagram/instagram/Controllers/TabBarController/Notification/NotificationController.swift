//
//  NotificationController.swift
//  instagram
//
//  Created by 서원지 on 2022/04/27.
//

import UIKit

final class NotificationController:  UITableViewController {
    
    //MARK: - Properties
    private var  notifications = [Notification]() {
        didSet { tableView.reloadData() }
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        configureUI()
        fetchNotifications()
    }
    
    //MARK:  - API
    private func fetchNotifications() {
        DispatchQueue.main.async {
            NotificationService.fetchNotifications { notifications in
                self.notifications = notifications
                print("DEBUG: Notifications \(notifications)")
            }
        }
    }
    
    //MARK: - UI 관련
    private func configureUI() {
        configureTableView()
    }
    
    private func configureTableView() {
        navigationItem.title = "알림"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.textColorAsset ?? FeedUIText.colorWrongInput]
        tabBarController?.tabBar.barTintColor = .backgroundColor
        tableView.register(NotificationCell.self,
                           forCellReuseIdentifier: CellIdentifier.notificationCellIdentifier)
        tableView.rowHeight = 80
        tableView.separatorStyle = .none
    }
}

extension NotificationController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.notificationCellIdentifier, for: indexPath) as! NotificationCell
        return cell
    }
}

