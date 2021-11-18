//
//  AppDelegate.swift
//  MobileBanking
//
//  Created by Dima Savelyev on 28.07.2021.
//

import UIKit
import CoreData
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    static var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        FirebaseApp.configure()
        //MARK: Check auth by user
        window.rootViewController = UINavigationController(rootViewController: ViewController())
        window.makeKeyAndVisible()
        AppDelegate.window = window
        return true
    }
}

