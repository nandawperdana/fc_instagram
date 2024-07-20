//
//  File 2.swift
//  InstagramClone
//
//  Created by nandawperdana on 15/07/24.
//

import Foundation
import UIKit

let userCellId = "UserCell"

class SearchController: UITableViewController {
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Config UI
    private func configureUI() {
        view.backgroundColor = UIColor.systemCyan
        
        tableView.register(UserCell.self, forCellReuseIdentifier: userCellId)
    }
}

extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCellId, for: indexPath)
        cell.backgroundColor = .brown
        return cell
    }
}
