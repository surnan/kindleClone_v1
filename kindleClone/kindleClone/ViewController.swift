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
        fetchBooks()
    }
    
    func fetchBooks() {
        print("Fetching books.....")
        if let url = URL(string: "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/kindle.json") {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let err = error {
                    print("Failed to fetch external JSON books: ", err)
                    return
                }
                guard let dataX = data else { return }
//                guard let dataString = String(data: dataX, encoding: .utf8) else { return }; print(dataString)
                
                do {
                    let json = try JSONSerialization.jsonObject(with: dataX, options: .mutableContainers)
                    
                    guard let bookDictionaries = json as? [[String:Any]]  else {return}
                    //outside bracket shows array, inner bracket shows dictionary
                    
                    self.books = []  // <-- without this line the self.books?.append results = NIL
                    for bookDictionary in bookDictionaries {
                        let book = Book(dictionary: bookDictionary)
                        self.books?.append(book)
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    // print(json)
                    //squigly brackets = dictionary[Any:Any]; square brackets = array
                    //We have an array of dictionaries
                    //Dictionary = [String: Any]
                } catch let jsonError {  //do loop
                    print("Failed to parse JSON properly", jsonError )
                }
            }).resume()  //this line needed to execute external fetch.  Apple should have named it '.execute()'
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = self.books?[indexPath.row]
        let layout = UICollectionViewFlowLayout()
        let bookPageController = BookPagerController(collectionViewLayout: layout)
        bookPageController.book = selectedBook
        let navController = UINavigationController(rootViewController: bookPageController)
        present(navController, animated: true, completion: nil)
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
       return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

