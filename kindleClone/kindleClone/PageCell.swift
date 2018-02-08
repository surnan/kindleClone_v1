//
//  PageCell.swift
//  kindleClone
//
//  Created by admin on 2/7/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "some text for our label some text for our label some text for our label"
        label.numberOfLines = 0  //allows size to grow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
        addSubview(textLabel)
        textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        textLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        textLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
