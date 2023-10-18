//
//  ChatController.swift
//  InChat
//
//  Created by Mac on 17.10.2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class ChatController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    var user: User?
    var messages = [Message]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .systemBackground

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        configureNavBar()
    }
    
    fileprivate func configureNavBar() {
        
        guard let user = self.user else {return}
        navigationItem.title = "@\(user.username ?? "")"
        
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(handleInfoButtonTapped), for: .touchUpInside)
        
        let infoBarButtonItem = UIBarButtonItem(customView: infoButton)
        navigationItem.rightBarButtonItem = infoBarButtonItem
        
    }
    
    @objc fileprivate func handleInfoButtonTapped() {
        print("Info button tapped")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //tabBarController?.tabBar.isHidden = true
        hideTabBar(isHidden: true, duration: 0.4)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //tabBarController?.tabBar.isHidden = false
        hideTabBar(isHidden: false, duration: 0.4)
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        
        return cell
    }
}
