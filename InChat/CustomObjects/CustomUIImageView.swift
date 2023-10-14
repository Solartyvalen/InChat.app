//
//  CustomUIImageView.swift
//  InChat
//
//  Created by Mac on 14.10.2023.
//

import UIKit

class CustomUIImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentMode = .scaleAspectFill
        backgroundColor = .lightGray
        clipsToBounds = true
    }
    
    
    
}
