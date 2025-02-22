//
//  AppDelegate.swift
//  PostsApp
//
//  Created by Moustafa on 21/02/2025.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router: SplashRouter?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window {
            
            router = SplashRouter(
                window: window,
                navigationController: CustomNavigationController()
            )
            
            router?.createSplashView()
        }
        return true
    }
}
