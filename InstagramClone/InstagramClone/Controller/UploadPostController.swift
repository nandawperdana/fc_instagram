//
//  UploadPostController.swift
//  InstagramClone
//
//  Created by nandawperdana on 23/07/24.
//

import UIKit

class UploadPostController: UIViewController {
    // MARK: Properties
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(systemName: "photo.fill")
        return iv
    }()
    
    private var captionTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Caption"
        tv.font = UIFont.systemFont(ofSize: 16)
        return tv
    }()
    
    private let characterCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
        return label
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Config UI
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Upload Post"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onTapCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(onTapShare))
        
        view.addSubview(photoImageView)
        photoImageView.setDimensions(height: 132, width: 132)
        photoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 16)
        photoImageView.centerX(inView: view)
        photoImageView.layer.cornerRadius = 10
        
        view.addSubview(captionTextView)
        captionTextView.anchor(top: photoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16, height: 72)
        
        view.addSubview(characterCountLabel)
        characterCountLabel.anchor(bottom: captionTextView.bottomAnchor, right: view.rightAnchor, paddingRight: 16)
    }
    
    // MARK: Actions
    @objc func onTapCancel() {
        print("onTapCancel")
    }
    
    @objc func onTapShare() {
        print("onTapShare")
    }
}
