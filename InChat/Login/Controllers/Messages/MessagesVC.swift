//
//  MessagesVC.swift
//  InChat
//
//  Created by Mac on 14.10.2023.
//

import Foundation
import FirebaseCore
import Firebase
import FirebaseFirestore

fileprivate let cellId = "cellId"

class MessagesVC: UITableViewController {
    
    //MARK: - Properties
    
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MessagesCell.self, forCellReuseIdentifier: cellId)
        
       configureNavigationBar()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MessagesCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Try to showcase")
    }
    
    
    fileprivate func configureNavigationBar() {
        navigationItem.title = "Сообщения"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createMessage))
    }
   
    @objc fileprivate func createMessage() {
       
     let newMessageVC = NewMessageVC()
        newMessageVC.messagesController = self
        let navcontroller = UINavigationController(rootViewController: newMessageVC)
        present(navcontroller, animated: true, completion: nil)
    }
    
    func showChatController(for user: User) {
       // print("show chat controller")
        let chatController = ChatController(collectionViewLayout: UICollectionViewFlowLayout())
        chatController.user = user
        navigationController?.pushViewController(chatController, animated: true)
    }
    
}
