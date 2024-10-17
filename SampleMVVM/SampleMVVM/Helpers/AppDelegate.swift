//
//  AppDelegate.swift
//  SampleMVVM
//
//  Created by Sedat on 15.10.2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController(rootViewController: TaskListViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
