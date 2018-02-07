 //
 //  BookPagerControler.swift
 //  kindleClone
 //
 //  Created by admin on 2/6/18.
 //  Copyright © 2018 admin. All rights reserved.
 //
 
 import UIKit
 
 class BookPagerController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        navigationItem.title = "!!BOOK!!"
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellID")
        
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .horizontal //scroll direction not a member of collectionViewLayout
        //So downcast needed to establish scroll direction
        
        layout?.minimumLineSpacing = 0  //makes it lines up on left edge
        collectionView?.isPagingEnabled = true  //scroll one page at a time
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)  //makes view screen size
    }
    
    
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
        
        /*
        if indexPath.item % 2 == 0 {
            cell.backgroundColor = .red
        } else {
            cell.backgroundColor = .blue
        }
  */
        
        return cell
    }
    
    
    
 }
