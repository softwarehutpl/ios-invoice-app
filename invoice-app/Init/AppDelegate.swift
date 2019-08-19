//
//  AppDelegate.swift
//  invoice-app
//
//  Created by Michał Karpowicz on 05/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    var appCoordinator: AppCoordinatorType?
    
    override init() {
        super.init()
        InitializationAssembly().resolveDependencies(appDelegate: self)
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appCoordinator?.start(window: window!)
        window!.makeKeyAndVisible()
        return true
    }
}
