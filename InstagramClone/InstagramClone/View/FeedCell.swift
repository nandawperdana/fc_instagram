//
//  FeedCell.swift
//  InstagramClone
//
//  Created by nandawperdana on 15/07/24.
//

import Foundation
import UIKit

class FeedCell: UICollectionViewCell {
    // MARK: Properties
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .systemGray
        iv.tintColor = .white
        iv.image = UIImage(systemName: "person.fill")
        return iv
    }()
    
    private let usernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("username", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(onTapUsername), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) has not been implemented")
    }
    
    // MARK: Configure UI
    private func configureUI() {
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 16)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        
        addSubview(usernameButton)
        usernameButton.centerY(inView: profileImageView , leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
    }
    
    // MARK: Actions
    @objc func onTapUsername() {
        print("On tap username")
    }
}
