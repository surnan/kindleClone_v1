//
//  BookCell.swift
//  kindleClone
//
//  Created by admin on 2/4/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {
    
    var book: Book? {   // <-- you are giving VC ability to set these values by assigning a whole cell to 'Book' object
        didSet {
            titleLabel.text = book?.title
            authorLabel.text = book?.author
            
            guard let coverImageUrl = book?.coverImageURL else {return}
            guard let url = URL(string: coverImageUrl) else {return}
            
            coverImageView.image = nil  //clears out the previous image.
                                        //So you don't old image from cell recycle
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let err = error {
                    print("Failed to retrieve our book cover image: ", err)
                    return
                }
                
                guard let imageData = data else {return}
                let image = UIImage(data: imageData)
                DispatchQueue.main.async {
                    self.coverImageView.image = image  //self needed here because of URLSession closure
                }
//                 print(data)  //without resume you don't execute 'print(data)' statement
            }.resume()
        }
    }
    
    private let coverImageView: UIImageView = {   //cell.book = book
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "steve_jobs")
        return imageView
    }()
    
    private let titleLabel: UILabel = {  //cell.book = book
        let label = UILabel()
        label.textColor = .white
        label.text = "Unable to load value for label.text"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    private let authorLabel: UILabel = {  //cell.book = book  
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "Unable to load value for authorlabel.text"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear  //now the default .lightgrey color set earlier will be color for all rows
        addSubview(coverImageView); addSubview(titleLabel); addSubview(authorLabel)
        
        coverImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        coverImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        coverImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        titleLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10).isActive = true
        
        authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        authorLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 8).isActive = true
        authorLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
