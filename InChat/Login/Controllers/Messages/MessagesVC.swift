//
//  MessagesVC.swift
//  InChat
//
//  Created by Mac on 14.10.2023.
//

import Foundation
import Firebase

fileprivate let cellId = "cellId"

class MessagesVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(MessagesCell.self, forCellReuseIdentifier: cellId)
        
       configureNavigationBar()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
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
        print("New message")
    }
    
}
