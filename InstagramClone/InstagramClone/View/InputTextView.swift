//
//  InputTextView.swift
//  InstagramClone
//
//  Created by nandawperdana on 23/07/24.
//

import UIKit

class InputTextView: UITextView {
    // MARK: Properties
    var placeholderText: String? {
        didSet { placeholderLabel.text = placeholderText }
    }
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        return label
    }()
    
    var placeholderShouldCenter = true {
        didSet {
            if placeholderShouldCenter {
                placeholderLabel.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 16)
                placeholderLabel.centerY(inView: self)
            } else {
                placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
            }
        }
    }
    
    // MARK: Lifecyle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Config UI
    private func configureUI() {
        addSubview(placeholderLabel)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onTextChanged), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    // MARK: Actions
    @objc func onTextChanged() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}
