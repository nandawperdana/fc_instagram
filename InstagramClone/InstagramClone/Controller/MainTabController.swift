//
//  MainTabController.swift
//  InstagramClone
//
//  Created by nandawperdana on 15/07/24.
//

import Foundation
import UIKit
import FirebaseAuth
import YPImagePicker

class MainTabController: UITabBarController {
    // MARK: Vars
    var user: User? {
        didSet {
            guard let user = user else { return }
            configureViewControllers(withUser: user)
        }
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchIsUserLoggedIn()
        fetchUser()
    }
    
    // MARK: Configure UI
    private func configureViewControllers(withUser user: User) {
        tabBar.isTranslucent = false
        view.backgroundColor = .white
        self.delegate = self
        
        let feed = templateNavController(unSelectedImage: UIImage(systemName: "house")!, selectedImage: UIImage(systemName: "house.fill")!, viewController: FeedController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        let search = templateNavController(unSelectedImage: UIImage(systemName: "magnifyingglass.circle")!, selectedImage: UIImage(systemName: "magnifyingglass.circle.fill")!, viewController: SearchController())
        
        let post = templateNavController(unSelectedImage: UIImage(systemName: "plus.app")!, selectedImage: UIImage(systemName: "plus.app.fill")!, viewController: PostController())
        
        let notification = templateNavController(unSelectedImage: UIImage(systemName: "heart")!, selectedImage: UIImage(systemName: "heart.fill")!, viewController: NotificationController())
        
        let profile = templateNavController(unSelectedImage: UIImage(systemName: "person.crop.circle")!, selectedImage: UIImage(systemName: "person.crop.circle.fill")!, viewController: ProfileController(user: user))
        
        viewControllers = [feed, search, post, notification, profile]
        
        tabBar.tintColor = .black
    }
    
    private func templateNavController(unSelectedImage: UIImage, selectedImage: UIImage, viewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewController)
        nav.tabBarItem.image = unSelectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        
        return nav
    }
    
    private func didFinishPickingMedia(_ picker: YPImagePicker) {
        picker.didFinishPicking { items, cancelled in
            picker.dismiss(animated: true) {
                guard let selectedImage = items.singlePhoto?.image else { return }
                
                let controller = UploadPostController()
                controller.selectedImage = selectedImage
                controller.currentUser = self.user
                controller.delegate = self
                
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: false, completion: nil)
            }
        }
    }
    
    // MARK: API
    func fetchIsUserLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        UserService.shared.fetchUser(withUid: uid) { user in
            self.user = user
        }
    }
}

extension MainTabController: AuthenticationDelegate {
    func authenticationDidComplete() {
        fetchUser()
        self.dismiss(animated: true)
    }
}

// MARK: UITabBarControllerDelegate
extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        
        if index == 2 {
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo
            config.library.maxNumberOfItems = 1
            config.screens = [.library]
            config.startOnScreen = .library
            config.hidesStatusBar = false
            config.hidesBottomBar = false
            config.shouldSaveNewPicturesToAlbum = false
            
            let picker = YPImagePicker(configuration: config)
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
            
            didFinishPickingMedia(picker)
            
            return false
        }
        
        return true
    }
}

// MARK: UploadPostControllerDelegate
extension MainTabController: UploadPostControllerDelegate {
    func didFinishUploadPost(_ controller: UploadPostController) {
        selectedIndex = 0
        controller.dismiss(animated: true, completion: nil)
        
        guard let feedNav = viewControllers?.first as? UINavigationController else { return }
        guard let feed = feedNav.viewControllers.first as? FeedController else { return }
        feed.onTapRefresh()
    }
}
