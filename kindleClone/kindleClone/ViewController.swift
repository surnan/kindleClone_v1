//
//  ViewController.swift
//  kindleClone
//
//  Created by admin on 2/4/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

class Book {
    let title: String
    let author: String
    let pages: [Page]
    
    init(title: String, author: String, pages: [Page]) {
        self.title = title
        self.author = author
        self.pages = pages
    }
}

class Page {
    let number: Int
    let text: String
    
    init(number: Int, text: String) {
        self.number = number
        self.text = text
    }
}

class ViewController: UIViewController {
    var books: [Book]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupBooks()
    }
    
    
    func setupBooks(){
        let page1 = Page(number: 1, text: "Text for the first page")
        let page2 = Page(number: 2, text: "This is the text for second page")
        let pages = [page1, page2]
        
        let book = Book(title: "Steve Jobs", author: "Walter Isaacson", pages: pages)
        let book2 = Book(title: "Bill Gates: A Biography", author: "Michael Becraft", pages: [
            Page(number: 1, text: "Text for Page 1"),
            Page(number: 2, text: "Text for Page 2"),
            Page(number: 3, text: "Text for Page 3"),
            Page(number: 4, text: "Text for Page 4")
            ])
        
        
        self.books = [book, book2]
        
        
        guard let books = self.books else {return}
        
        for book in books {
            print(book.title)
            for page in book.pages {
                print(page.text)
            }
        }
      
        /*
         //BELOW IS ALSO GOOD
         if let unwrappedBooks = self.books {
         for book in unwrappedBooks {
         print(book.title)
         for page in book.pages {
         print(page.text)
         }
         }
         }
         */
    }
}

