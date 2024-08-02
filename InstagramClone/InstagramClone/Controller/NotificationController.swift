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
            self.checkIfUserIsFollowed()
        }
    }
    
    private func checkIfUserIsFollowed() {
        notifications.forEach { notif in
            guard notif.type == .follow else { return }
            
            UserService.shared.isUserFollowed(uid: notif.uid) { isFollowed in
                if let index = self.notifications.firstIndex(where: { $0.id == notif.id }) {
                    self.notifications[index].userIsFollowed = isFollowed
                }
            }
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
        cell.viewModel = NotificationViewModel(notification: notifications[indexPath.row])
        cell.delegate = self
        return cell
    }
}

// MARK: UITableViewDelegate
extension NotificationController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG: Select row \(indexPath.row)")
    }
}

extension NotificationController: NotificationCellDelegate {
    func call(_ cell: NotificationCell, wantsToFollow uid: String) {
        
    }
    
    func call(_ cell: NotificationCell, wantsToUnfollow uid: String) {
        
    }
    
    func call(_ cell: NotificationCell, wantsToViewPost postId: String) {
        
    }
}
