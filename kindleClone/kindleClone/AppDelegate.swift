//
//  AppDelegate.swift
//  kindleClone
//
//  Created by admin on 2/4/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit

//If the below code is put into ViewDidLoad, it doesn't change color for all items in navigation pane
//Like Carrier Signal & Clock
class LightStatusBarNavController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //below needed after deleting storyboard
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        
        
//        window?.rootViewController = ViewController()
//        //above needed after deleting storyboard
        
        window?.rootViewController = LightStatusBarNavController(rootViewController: ViewController())
        
        
        return true
    }
}
