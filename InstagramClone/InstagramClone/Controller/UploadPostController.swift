//
//  UploadPostController.swift
//  InstagramClone
//
//  Created by nandawperdana on 23/07/24.
//

import UIKit
import ProgressHUD

protocol UploadPostControllerDelegate: AnyObject {
    func didFinishUploadPost(_ controller: UploadPostController)
}

class UploadPostController: UIViewController {
    // MARK: Properties
    var selectedImage: UIImage? {
        didSet { photoImageView.image = selectedImage }
    }
    
    var currentUser: User?
    
    var delegate: UploadPostControllerDelegate?
    
    private let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(systemName: "photo.fill")
        return iv
    }()
    
    private lazy var captionTextView: InputTextView = {
        let tv = InputTextView()
        tv.placeholderText = "Caption"
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.delegate = self
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
    func checkMaxLength(_ textView: UITextView) {
        if (textView.text.count) > 100 {
            textView.deleteBackward()
        }
    }
    
    @objc func onTapCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func onTapShare() {
        guard let caption = captionTextView.text else { return }
        guard let image = selectedImage else { return }
        guard let user = currentUser else { return }
        
        PostService.shared.postAnImage(caption: caption, image: image, user: user) { error in
            ProgressHUD.dismiss()
            
            if let error = error {
                print("DEBUG: Failed to upload post, error: \(error.localizedDescription)")
                return
            }
            
            self.delegate?.didFinishUploadPost(self)
        }
    }
}

// MARK: UITextViewDelegate
extension UploadPostController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        checkMaxLength(textView)
        let count = textView.text.count
        characterCountLabel.text = "\(count)/100"
    }
}
