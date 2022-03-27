//
//  AppDelegate.swift
//  InstaGalleryDemo
//
//  Created by Manuel Rodríguez Sebastián on 29/10/2019.
//  Copyright © 2019 MRodriguez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = UINavigationController(rootViewController: TestViewController())
        window?.makeKeyAndVisible()
        
        return true
    }
}

