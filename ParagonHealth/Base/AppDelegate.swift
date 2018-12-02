//
//  AppDelegate.swift
//  ParagonHealth
//
//  Created by otto on 12/1/18.
//  Copyright © 2018 ParagonHealth. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupNavBAr()
        
        return true
    }
    
    func setupNavBAr() {
        UINavigationBar.appearance().barTintColor = UIColor(red: 1.0/255.0, green: 133.0/255.0, blue: 179.0/255.0, alpha: 1.0)
       
        if let _ = UIFont(name: "Helvetica", size: 24.0) {
            if #available(iOS 11.0, *) {
                UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
            } else {
                UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
            }
        }
        
    }
}

