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
            nibName: "C_FoldersViewController",
            bundle: nil
        )
        main.mediator = RealmFoldersMediator(
            folderManager: FoldersManager(),
            realmManager: RealmManager())
        main.router = FoldersRouter(owner: main)
        let nav = UINavigationController(rootViewController: main)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
}
