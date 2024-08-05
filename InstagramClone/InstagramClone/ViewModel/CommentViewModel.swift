//
//  CommentViewModel.swift
//  InstagramClone
//
//  Created by nandawperdana on 27/07/24.
//

import UIKit

struct CommentViewModel {
    private let comment: Comment
    
    init(comment: Comment) {
        self.comment = comment
    }
    
    var profileImageUrl: URL? {
        return URL(string: comment.profileImage)
    }
    
    func commentLabelText() -> NSAttributedString {
        let attrString = NSMutableAttributedString(string: "\(comment.username) ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attrString.append(NSAttributedString(string: comment.comment, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        
        return attrString
    }
    
    func size(forWidth width: CGFloat) -> CGSize {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = comment.comment
        label.lineBreakMode = .byWordWrapping
        label.setWidth(width)
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
