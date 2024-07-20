//
//  ProfileHeader.swift
//  InstagramClone
//
//  Created by nandawperdana on 20/07/24.
//

import UIKit
import SDWebImage

class ProfileHeader: UICollectionReusableView {
    // MARK: Properties
    var viewModel: ProfileHeaderViewModel? {
        didSet { setData() }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        iv.backgroundColor = .systemGray
        iv.tintColor = .white
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("Loading", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray5
        button.addTarget(self, action: #selector(onTapEditProfile), for: .touchUpInside)
        return button
    }()
    
    private lazy var postLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.attributedText = attributedStatText(value: 10, label: "Posts")
        return label
    }()
    
    private lazy var followerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapFollower))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        label.attributedText = attributedStatText(value: 10, label: "Followers")
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(onTapFollowing))
        label.addGestureRecognizer(tap)
        label.isUserInteractionEnabled = true
        label.attributedText = attributedStatText(value: 10, label: "Following")
        return label
    }()
    
    private let gridButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "squareshape.split.3x3"), for: .normal)
        return button
    }()
    
    private let listButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "rectangle.grid.1x2.fill"), for: .normal)
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
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 16)
        profileImageView.setDimensions(height: 90, width: 90)
        profileImageView.layer.cornerRadius = 90/2
        
        addSubview(nameLabel)
        nameLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 16)
        
        addSubview(editProfileButton)
        editProfileButton.anchor(top: nameLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 16)
        
        let labelStack = UIStackView(arrangedSubviews: [postLabel, followerLabel, followingLabel])
        labelStack.distribution = .fillEqually
        addSubview(labelStack)
        labelStack.anchor(left: profileImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 16, height: 50)
        labelStack.centerY(inView: profileImageView)
        
        let buttonStack = UIStackView(arrangedSubviews: [gridButton, listButton])
        buttonStack.distribution = .fillEqually
        addSubview(buttonStack)
        buttonStack.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 50)
    }
    
    // MARK: Load Data
    private func setData() {
        guard let viewModel = viewModel else { return }
        
        nameLabel.text = viewModel.fullName
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
    }
    
    
    // MARK: Actions
    @objc func onTapEditProfile() {
        
    }
    @objc func onTapFollower() {
        
    }
    @objc func onTapFollowing() {
        
    }
    
    func attributedStatText(value: Int, label: String) -> NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: label, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray]))
        return attributedText
    }
}