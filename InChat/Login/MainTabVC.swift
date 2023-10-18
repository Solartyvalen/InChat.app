//
//  MainTabVC.swift
//  InChat
//
//  Created by Mac on 07.10.2023.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import FirebaseFirestore

class MainTabVC: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        tabBar.tintColor = .black
        
        
        
        configure()
        
       // ifUserLogIn()
    }
    
    func configure() {
        let feed = createNavController(viewController: FeedController(collectionViewLayout: UICollectionViewLayout()), title: "Feed", unselectedImage: UIImage(imageLiteralResourceName: "home_unselected"))
        let search = createNavController(viewController: UIViewController(), title: "Search", unselectedImage: UIImage(imageLiteralResourceName: "search_selected"))
        let newPost = createNavController(viewController: UIViewController(), title: "Post", unselectedImage: UIImage(imageLiteralResourceName: "post"))
        let likes = createNavController(viewController: UIViewController(), title: "Likes", unselectedImage: UIImage(imageLiteralResourceName: "like_unselected"))
        let profile = createNavController(viewController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()), title: "Profile", unselectedImage: UIImage(imageLiteralResourceName: "profile_unselected"))
        
        viewControllers = [feed, search, newPost, likes, profile]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser == nil{
            
            let LoginVC = LoginController()
            let navController = UINavigationController(rootViewController: LoginVC)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: false, completion: nil)
            
      } else {
         print("USER IS LOGGED IN")
          //configure()
      }
    }
    /*
    fileprivate func ifUserLogIn() {
    if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let loginVC = LoginController()
            let navController = UINavigationController(rootViewController: loginVC)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            }
        } else {
            print("User is Logged in")
            configure()
        }
    }
    */
    fileprivate func createNavController(viewController: UIViewController, title: String, unselectedImage: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.title = title
        viewController.navigationItem.title = title
        
        navController.tabBarItem.image = unselectedImage
        
        viewController.view.backgroundColor = .white
        
        return navController
    }

}
