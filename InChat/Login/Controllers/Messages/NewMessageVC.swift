//
//  NewMessageVC.swift
//  InChat
//
//  Created by Mac on 15.10.2023.
//

import UIKit
import FirebaseCore
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

fileprivate let cellId = "newMessageCellId"

class NewMessageVC: UITableViewController {
    
    var users: [User] = []
    var messagesController: MessagesVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(NewMessageCell.self, forCellReuseIdentifier: cellId)
        
       configureNavigationBar()
     fetchUsersFromFirestore()
    }
    
    //MARK: - API Section
    
    func fetchUsersFromFirestore() {
        
        Firestore.firestore().collection("users").getDocuments { (snapshot, err) in
            if let err = err {
                print("Failed to fetch users with err: ", err.localizedDescription)
                return
            }
            
            snapshot?.documents.forEach({ (documentSnapshot) in
                let userDictionary = documentSnapshot.data()
                let user = User(dictionary: userDictionary)
                
              //  print(userDictionary)
               // print(user.username ?? "")
                
                if user.uid != Auth.auth().currentUser?.uid {
                    
                    self.users.append(user)
                    self.tableView.reloadData()
                }
            })
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NewMessageCell
        
        cell.user = users[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Try to showcase")
        
        self.dismiss(animated: true) {
            let user = self.users[indexPath.row]
            self.messagesController?.showChatController(for: user)
        }
    }
    
    
    fileprivate func configureNavigationBar() {
        navigationItem.title = "Новое Сообщение"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Oтмена", style: .plain, target: self, action: #selector(handleCansel))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
   
    @objc fileprivate func handleCansel() {dismiss(animated: true, completion: nil)}
    
}
