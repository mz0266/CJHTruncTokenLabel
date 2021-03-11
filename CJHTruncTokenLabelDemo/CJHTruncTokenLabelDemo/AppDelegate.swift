//
//  AppDelegate.swift
//  CJHTruncTokenLabelDemo
//
//  Created by CJH on 2021/3/11.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    let window = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window.backgroundColor = .white
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
        return true
    }

}

