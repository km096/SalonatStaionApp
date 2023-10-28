//
//  SceneDelegate.swift
//  SalonatStationApp
//
//  Created by ME-MAC on 10/15/23.
//

import UIKit
import MOLH

class SceneDelegate: UIResponder, UIWindowSceneDelegate, MOLHResetable {
    
    

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

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//        autologin()
        setupNavBar()
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

extension SceneDelegate {
    fileprivate func setupNavBar() {
        
        let textAttributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Cairo-Regular", size: 20) ?? UIFont()]
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            
            UINavigationBar.appearance().isTranslucent = false
            appearance.backgroundColor =  #colorLiteral(red: 0.979714334, green: 0.8133532405, blue: 0.8037056327, alpha: 1)
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.979714334, green: 0.8133532405, blue: 0.8037056327, alpha: 1)
            
            UINavigationBar.appearance().titleTextAttributes = textAttributes
            
            UINavigationBar.appearance().isTranslucent = false
            
        }
    }
    
    func autologin() {
        guard (UserDefaults.standard.value(forKey: Constants.AccessTokenKey) != nil) else {
            
            return
        }
        DispatchQueue.main.async {
            self.goToHomeScreen()
        }
    }
    
    
    func goToHomeScreen() {
        guard let homeView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: Constants.Identifiers.tabBarController) as? TabBarController else {
            return
        }
        self.window?.rootViewController = homeView
    }
}
