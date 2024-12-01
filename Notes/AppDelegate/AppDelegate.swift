//
//  AppDelegate.swift
//  Notes
//
//  Created by duc nguyen on 30/11/2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let main = C_FoldersViewController(
            nibName: String(describing: C_FoldersViewController.self),
            bundle: nil)
        let nav = UINavigationController(rootViewController: main)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
}
