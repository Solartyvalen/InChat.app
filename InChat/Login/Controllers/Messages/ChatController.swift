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
    
    lazy var containerView: UIView = {
        let view = UIView()
        
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 55)
        
        view.addSubview(messageTextField)
        messageTextField.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 12, bottom: 0, right: 4))
        
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        
        view.addSubview(sendButton)
        sendButton.anchor(top: nil, leading: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 16))
        sendButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let separator = UIView()
        view.addSubview(separator)
        separator.backgroundColor = .lightGray
        separator.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .zero, size: .init(width: 0, height: 0.5))
        
        return view
    }()
    
    let messageTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter text..."
        return tf
    }()
    
    @objc fileprivate func handleSend() {
        print("Send")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        // Register cell classes
        self.collectionView!.register(ChatCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
        configureNavBar()
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
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
        print("Info button taped")
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
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatCell
        
        // Configure the cell
       // cell.backgroundColor = .systemBlue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
}
