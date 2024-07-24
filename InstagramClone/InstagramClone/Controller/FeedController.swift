//
//  File.swift
//  InstagramClone
//
//  Created by nandawperdana on 15/07/24.
//

import Foundation
import UIKit

class FeedController: UICollectionViewController {
    // MARK: Properties
    private var posts: [Post] = []
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        fetchPosts()
    }
    
    // MARK: Configure UI
    private func configureUI() {
        collectionView.backgroundColor = .white
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: "Cell")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(onTapLogout))
    }
    
    // MARK: Actions
    @objc func onTapLogout() {
        AuthService.shared.logoutUser()
        let controller = LoginController()
        controller.delegate = self.tabBarController as? MainTabController
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
    
    // MARK: API
    private func fetchPosts() {
        PostService.shared.fetchPosts { posts in
            self.posts = posts
            self.collectionView.reloadData()
            
//            posts.forEach { post in
//                print("Post data: \(post)")
//            }
        }
    }
}


// MARK: UICollectionView Data Source
extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.viewModel = PostViewModel(post: self.posts[indexPath.row])
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height = width + 12 + 40 + 8
        height += 50
        height += 60
        
        return CGSize(width: width, height: height)
    }
}
