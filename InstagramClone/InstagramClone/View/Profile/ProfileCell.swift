//
//  ProfileCell.swift
//  InstagramClone
//
//  Created by nandawperdana on 20/07/24.
//

import UIKit

class ProfileCell: UICollectionViewCell {
    // MARK: Properties
    
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
        backgroundColor = .systemGray
    }
}
