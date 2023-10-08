//
//  MainTabVC.swift
//  InChat
//
//  Created by Mac on 07.10.2023.
//

import UIKit
import Firebase

class MainTabVC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        tabBar.tintColor = .black
        
        let feed = createNavController(viewController: FeedController(collectionViewLayout: UICollectionViewLayout()), title: "Feed", unselectedImage: UIImage(imageLiteralResourceName: "home_unselected"))
        let search = createNavController(viewController: UIViewController(), title: "Search", unselectedImage: UIImage(imageLiteralResourceName: "search_selected"))
        let newPost = createNavController(viewController: UIViewController(), title: "Post", unselectedImage: UIImage(imageLiteralResourceName: "post"))
        let likes = createNavController(viewController: UIViewController(), title: "Likes", unselectedImage: UIImage(imageLiteralResourceName: "like_unselected"))
        let profile = createNavController(viewController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()), title: "Profile", unselectedImage: UIImage(imageLiteralResourceName: "profile_unselected"))
        
        viewControllers = [feed, search, newPost, likes, profile]
        
        ifUserLogIn()
    }
    
    fileprivate func ifUserLogIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginVC = LoginController()
                let navController = UINavigationController(rootViewController: loginVC)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            }
            
            return
        }
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, unselectedImage: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        viewController.navigationItem.title = title
        
        navController.tabBarItem.image = unselectedImage
        
        viewController.view.backgroundColor = .white
        
        return navController
    }

}
