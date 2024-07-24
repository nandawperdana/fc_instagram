//
//  ImageUploaderService.swift
//  InstagramClone
//
//  Created by nandawperdana on 17/07/24.
//

import UIKit
import FirebaseStorage
import ProgressHUD

class ImageUploaderService {
    static let shared = ImageUploaderService()
    
    private init() { }
    
    func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.6) else { return }
        
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/ProfileImage/\(filename)" + ".jpg")
        var task: StorageUploadTask!
        
        task = ref.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("DEBUG: Failed to upload image \(error.localizedDescription)")
                ProgressHUD.dismiss()
                return
            }
            
            ref.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            }
        }
        
        task.observe(StorageTaskStatus.progress) { snapshot in
            guard let snapshotProgress = snapshot.progress else { return }
            
            let progress = snapshotProgress.completedUnitCount / snapshotProgress.totalUnitCount
            ProgressHUD.progress(CGFloat(progress))
        }
    }
}
