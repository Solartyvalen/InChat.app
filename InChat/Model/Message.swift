//
//  Message.swift
//  InChat
//
//  Created by Mac on 17.10.2023.
//

import UIKit
import FirebaseCore
import Firebase
import FirebaseFirestore
import FirebaseAuth

class Message {
    
    let text, fromId, ToId: String
    let timestamp: Timestamp
    let isMessageFromCurrentUser: Bool
    
    init(dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.ToId = dictionary["toId"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        
        self.isMessageFromCurrentUser = Auth.auth().currentUser?.uid == self.fromId
        
    }
}
