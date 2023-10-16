//
//  NewMessageCell.swift
//  InChat
//
//  Created by Mac on 15.10.2023.
//

import UIKit
import Firebase

class NewMessageCell: UITableViewCell {
    
    // MARK: - Properties
    
    var user: User? {
        didSet {
            
            guard let url = URL(string: user?.profileImage ?? "") else {return}
            
            profileImageView.loadImage(with: user?.profileImage ?? "")
            
            guard let username = user?.username else {return}
            guard let fullname = user?.name else {return}
            
            textLabel?.text = username
            detailTextLabel?.text = fullname
        }
    }
    
    let profileImageView = CustomUIImageView(frame: .zero)
    
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(profileImageView)
        
        profileImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 12, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        profileImageView.layer.cornerRadius = 50 / 2
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
       // textLabel?.text = user?.username
       // detailTextLabel?.text = user?.name
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 70, y: textLabel!.frame.origin.y - 2, width: (textLabel?.frame.width)!, height: (textLabel?.frame.height)!)
        
        detailTextLabel?.frame = CGRect(x: 70, y: detailTextLabel!.frame.origin.y + 2, width: frame.width - 110, height: (detailTextLabel?.frame.height)!)
        
        textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        detailTextLabel?.textColor = .systemGray2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
