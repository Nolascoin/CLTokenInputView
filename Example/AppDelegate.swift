//
//  AppDelegate.swift
//  Example
//
//  Created by Alex Nolasco on 2/10/19.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        
        let viewController = ViewController()
        let nav = UINavigationController(rootViewController: viewController)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        return true
    }
}

