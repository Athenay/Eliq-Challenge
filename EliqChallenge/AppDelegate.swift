//
//  AppDelegate.swift
//  EliqChallenge
//
//  Created by Athena Yousefi on 11/4/20.
//  Copyright © 2020 Athena Yousefi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow()
        self.window?.rootViewController = CurrencyDependencyContainer().makeCurrencyViewController()
        self.window?.makeKeyAndVisible()
        return true
    }


}

