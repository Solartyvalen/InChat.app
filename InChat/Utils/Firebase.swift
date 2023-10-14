//
//  Firebase.swift
//  InChat
//
//  Created by Mac on 10.10.2023.
//

import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore

extension Firestore {
    
    func fetchCurrentUser(completion: @escaping (User?, Error?) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        Firestore.firestore().collection("users").document(uid).getDocument { (snapshot, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            
            guard let dictionary = snapshot?.data() else {return}
            let user = User(dictionary: dictionary)
            completion(user, nil)
        }
    }
}

