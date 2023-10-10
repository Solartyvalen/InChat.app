//
//  UserProfileController.swift
//  InChat
//
//  Created by Mac on 08.10.2023.
//

import UIKit
import Firebase
import FirebaseFirestore

private let reuseIdentifier = "Cell"
private let userReuseIdentifier = "UserProfileCell"

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: userReuseIdentifier)
        
        fetchCurrentUser()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - API
    
    var user: User?
    
    fileprivate func fetchCurrentUser() {
        
        Firestore.firestore().fetchCurrentUser { (user, err) in
            if let err = err {
                print("Faild to fetch user", err.localizedDescription)
                return
            }
            
            self.user = user
            print(user?.username ?? "")
            
           // self.navigationItem.title = user?.username
            
            /*  guard let currentUid = Auth.auth().currentUser?.uid else {return}
             Firestore.firestore().collection("users").document(currentUid).getDocument { (snapshot, err) in
             if let err = err {
             print("Faild", err.localizedDescription)
             return
             }
             guard let dictionary = snapshot?.data() else {return}
             let user = User(dictionary: dictionary)
             self.user = user
             // print(user.name ?? "")
             */
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: userReuseIdentifier, for: indexPath) as! UserProfileHeader
        return header
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

}
