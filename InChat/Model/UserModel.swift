//
//  Model.swift
//  InChat
//
//  Created by Mac on 08.10.2023.
//

import Foundation


class User {
    
    var name: String!
    var username: String!
    var profileImage: String!
    var uid: String!
    
    init(dictionary: [String: Any]) {
        
        self.name = dictionary["name"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.profileImage = dictionary["profileImageUrl"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        
    }
}
