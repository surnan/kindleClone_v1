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
        setupNavigationBarStyles()
        setupNavBarButtons()
        navigationItem.title = "My Kindle"
        tableView.register(BookCell.self, forCellReuseIdentifier: "myCellID")
        tableView.tableFooterView = UIView()  //Removes excess rows (which are shown blank) from screen
        
//        tableView.backgroundColor = .lightGray  //after making cell rows clear, it becomes color for all rows
       tableView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        tableView.separatorColor = UIColor(white: 0, alpha: 0.5)
        
        fetchBooks()
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(displayP3Red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        
        let segmentedControl = UISegmentedControl(items: ["Cloud", "Device"])
        footerView.addSubview(segmentedControl)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        segmentedControl.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        segmentedControl.tintColor = .white
        segmentedControl.selectedSegmentIndex = 0
        
        let gridButton = UIButton(type: .system)
        gridButton.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        gridButton.tintColor = .white
        
        footerView.addSubview(gridButton)
        gridButton.translatesAutoresizingMaskIntoConstraints = false
        gridButton.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: 15).isActive = true
        gridButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        gridButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        gridButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        let sortButton = UIButton(type: .system)
        sortButton.setImage(#imageLiteral(resourceName: "sort"), for: .normal)
        sortButton.tintColor = .white
        
        footerView.addSubview(sortButton)
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        sortButton.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -15).isActive = true
        sortButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        sortButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sortButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        
        
        
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func setupNavigationBarStyles() {
//        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }

    func setupNavBarButtons() { //renderingMode keeps original color palette.  Otherwise they are blue
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenuPress))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "amazon_icon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAmazonIconPress))
    }
    
    
    @objc func handleAmazonIconPress() {
        print("Amazon button pressed")
    }
    
    @objc func handleMenuPress() {
        print("Menu button pressed")
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

