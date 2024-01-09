//
//  AppDelegate.swift
//  Practice1
//
//  Created by Chamith Mirissage on 2023-04-06.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FBSDKCoreKit
import TwitterKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let kTwitterConsumerKey = "BuX7PI9aCTJGw0NqVTJcz5oaa"
    let kTwitterCOnsumerSecret = "GUx530I0ZLEDKzQONA6GNszkgavh5JTAZEnNTLbe44zgma1Vx6"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ApplicationDelegate.shared.application(
                    application,
                    didFinishLaunchingWithOptions: launchOptions
                )
        TWTRTwitter.sharedInstance().start(withConsumerKey: kTwitterConsumerKey, consumerSecret: kTwitterCOnsumerSecret)
        
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

