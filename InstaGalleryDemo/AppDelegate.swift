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

    let window = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        let navigationController = UINavigationController(rootViewController: ViewController())
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return true
    }
}

