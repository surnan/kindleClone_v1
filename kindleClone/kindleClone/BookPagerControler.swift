 //
//  BookPagerControler.swift
//  kindleClone
//
//  Created by admin on 2/6/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
 
 class BookPagerController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
        navigationItem.title = "!!BOOK!!"
        
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
    
        
        cell.backgroundColor = .red
        
        return cell
    
    }
    
    
    
 }
