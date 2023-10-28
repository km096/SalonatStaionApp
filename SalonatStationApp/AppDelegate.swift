//
//  AppDelegate.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/15/23.
//

import UIKit
import MOLH

@main
class AppDelegate: UIResponder, UIApplicationDelegate, MOLHResetable{
    var window: UIWindow?
    
    func reset() {
        let token = UserDefaults.standard.object(forKey: "\(Constants.AccessTokenKey)")
        let storyboard  = UIStoryboard(name: "Main", bundle: nil)
        if token != nil {
            window?.rootViewController = storyboard.instantiateViewController(withIdentifier: Constants.Identifiers.tabBarController)
        } else {
            window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "NavigationID")
        }
        
    }
    



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        MOLH.shared.activate(true)
        reset()
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


