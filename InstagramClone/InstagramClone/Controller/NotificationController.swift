//
//  File4.swift
//  InstagramClone
//
//  Created by nandawperdana on 15/07/24.
//

import Foundation
import UIKit

private let reuseIdentifier = "NotificationCell"

class NotificationController: UITableViewController {
    // MARK: Properties
    private var notifications = [Notification]() {
        didSet { tableView.reloadData() }
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        fetchNotifications()
    }
    
    // MARK: Config UI
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Notifications"
        
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        tableView.register(NotificationCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: API
    private func fetchNotifications() {
        NotificationService.shared.fetchNotifications { notifications in
            self.notifications = notifications
        }
    }
}

// MARK: UITableViewDataSource
extension NotificationController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NotificationCell
        return cell
    }
}

// MARK: UITableViewDelegate
extension NotificationController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG: Select row \(indexPath.row)")
    }
}
