//
//  ViewController.swift
//  kindleClone
//
//  Created by admin on 2/4/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit



class ViewController: UITableViewController {  //specifying UITableVC makes tableview take the whole screen
    var books: [Book]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My Kindle"
 
        tableView.register(BookCell.self, forCellReuseIdentifier: "myCellID")
        tableView.tableFooterView = UIView()  //Removes excess rows (which are shown blank) from screen
        setupBooks()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = books?.count {  //crashes without taking into account situations where books is nil
            return count
        }
        
        return 0  // if you breakpoint 'return 0 & return count' you will see return 0 is ALWAYS executed first
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCellID", for: indexPath) as! BookCell //<-- downcast works because of line #20
                                                                                        // it registered with "BookCell"
        
        
        let book = books?[indexPath.row]
        cell.book = book   // this works because of 'var book: Book?' in class definition
        
//        Below is errors
//        cell.coverImageView.image = book?.image
//        cell.titleLabel.text = book?.title
//        cell.authorLabel.text = book?.author
//        cell.textLabel?.text = book?.title
//        cell.imageView?.image = book?.image

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func setupBooks(){
        let page1 = Page(number: 1, text: "Text for the first page")
        let page2 = Page(number: 2, text: "This is the text for second page")
        let pages = [page1, page2]
        
        let book1 = Book(title: "Steve Jobs", author: "Walter Isaacson", image: #imageLiteral(resourceName: "steve_jobs"), pages: pages)
        let book2 = Book(title: "Bill Gates: A Biography", author: "Michael Becraft", image: #imageLiteral(resourceName: "bill_gates"), pages: [
            Page(number: 1, text: "Text for Page 1"),
            Page(number: 2, text: "Text for Page 2"),
            Page(number: 3, text: "Text for Page 3"),
            Page(number: 4, text: "Text for Page 4")
            ])
        
        self.books = [book1, book2]
    }
}

