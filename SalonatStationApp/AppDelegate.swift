//
//  AppDelegate.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/15/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let appeatance = UITabBarItem.appearance()
        let textAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: CustomFont(index: .regular), size: 20) ?? UIFont()]
        appeatance.setTitleTextAttributes(textAttributes, for: .normal)
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


//extension AppDelegate {
//    fileprivate func setupNavBar() {
//        if #available(iOS 15, *) {
//            let appearance = UINavigationBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//            appearance.backgroundColor =  #colorLiteral(red: 0.979714334, green: 0.8133532405, blue: 0.8037056327, alpha: 1)
//            UINavigationBar.appearance().standardAppearance = appearance
//            UINavigationBar.appearance().scrollEdgeAppearance = appearance
//                    
//        }else{
//            UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.979714334, green: 0.8133532405, blue: 0.8037056327, alpha: 1)
//            UINavigationBar.appearance().tintColor = UIColor.black
//            
//        }
//        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: ChooseFont.regular.rawValue, size:20) ?? UIFont()]
//       
//    }
//}

