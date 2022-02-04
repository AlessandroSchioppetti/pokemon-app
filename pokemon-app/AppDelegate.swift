//
//  AppDelegate.swift
//  pokemon-app
//
//  Created by Alessandro Schioppetti on 09/06/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let splashController: SplashViewController = SplashViewController {
            self.window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
        }
        
        window?.rootViewController = splashController
        window?.makeKeyAndVisible()
        return true
    }
}



