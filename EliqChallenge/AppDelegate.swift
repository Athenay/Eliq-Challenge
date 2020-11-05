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
    lazy var networkAPI: NetworkAPI = {
        return NetworkAPI(decoder: JSONDecoder().getInstance())
    }()
    lazy var latestCurrencyFetcher: LatestCurrencyRateFetcher = {
        return LatestCurrencyRateFetcher(base: "EUR", fetchInterval: TimeInterval(Date.minutesInHour * Date.secondsInMinute), networkAPI: self.networkAPI)
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow()
        self.window?.rootViewController = UINavigationController(rootViewController: CurrencyDependencyContainer().makeCurrencyViewController())
        self.window?.makeKeyAndVisible()
        self.latestCurrencyFetcher.fetchLatestRates(completion: nil)
        return true
    }

    static func getInstance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

