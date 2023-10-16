//
//  ChatCell.swift
//  InChat
//
//  Created by Mac on 17.10.2023.
//

import UIKit

class ChatCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
