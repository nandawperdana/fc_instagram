//
//  CommentCell.swift
//  InstagramClone
//
//  Created by nandawperdana on 25/07/24.
//

import UIKit

class CommentCell: UICollectionViewCell {
    // MARK: Properties
    var comment: Comment? {
        didSet { setData() }
    }
    
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
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        let attrString = NSMutableAttributedString(string: "username ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attrString.append(NSAttributedString(string: "comment for this post...", attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        
        label.attributedText = attrString
        return label
    }()
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Config UI
    private func configureUI() {
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 16)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        
        commentLabel.numberOfLines = 0
        addSubview(commentLabel)
        commentLabel.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        commentLabel.anchor(right: rightAnchor, paddingRight: 16)
    }
    
    private func setData() {
        guard let comment = comment else { return }
        
        profileImageView.sd_setImage(with: URL(string: comment.profileImage))
        
        let attrString = NSMutableAttributedString(string: "\(comment.username) ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attrString.append(NSAttributedString(string: comment.comment, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        commentLabel.attributedText = attrString
    }
}
