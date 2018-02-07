 //
 //  BookPagerControler.swift
 //  kindleClone
 //
 //  Created by admin on 2/6/18.
 //  Copyright © 2018 admin. All rights reserved.
 //
 
 import UIKit
 
 class BookPagerController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var book: Book?  //We don't know value at initialization.  So we have to start with value = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        navigationItem.title = self.book?.title
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellID")
        
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .horizontal //scroll direction not a member of collectionViewLayout
        //So downcast needed to establish scroll direction
        
        layout?.minimumLineSpacing = 0  //makes it lines up on left edge
        collectionView?.isPagingEnabled = true  //scroll one page at a time
        
        //setting a close button on collectionView itself.  No need to bring in a navigationController for this feature
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(handleCloseBook))
    }
    
    
    @objc func handleCloseBook() {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 44 - 20)  //makes view screen size
            // '-44 = navigationHeight' & '-20 = statusBarHeight
        
    }
    
    
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return book?.pages.count  ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! PageCell
        
        /*
        if indexPath.item % 2 == 0 {
            cell.backgroundColor = .red
        } else {
            cell.backgroundColor = .blue
        }
  */
        
        
//        pageCell.textLabel.text = "Something from our pages"
        
        let page = book?.pages[indexPath.item]
        pageCell.textLabel.text = page?.text
        
        return pageCell
    }
    
    
    
 }
