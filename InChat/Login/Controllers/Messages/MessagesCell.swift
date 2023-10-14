//
//  MessagesCell.swift
//  InChat
//
//  Created by Mac on 14.10.2023.
//

import UIKit
import Firebase

class MessagesCell: UITableViewCell {
    
    // MARK: - Properties
    
    let profileImageView = CustomUIImageView(frame: .zero)
    
    let timeStamp: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "1h"
        label.textColor = .systemGray2
        return label
        
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(profileImageView)
        addSubview(timeStamp)
        
        profileImageView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 12, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        profileImageView.layer.cornerRadius = 50 / 2
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        timeStamp.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 15))
        
        textLabel?.text = "Solarty"
        detailTextLabel?.text = "как всегдва все хорошо и хорошо что все хорошо как всегда впрочем"
        
        
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
