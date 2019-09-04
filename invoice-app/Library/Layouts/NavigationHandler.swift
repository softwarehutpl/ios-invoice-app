//
//  NavigationHandler.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 02/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation

import UIKit

@objc protocol NavigationBarModifier {
    
    var isNavigationBarHidden: Bool { get }
    @objc optional var barTintColor: UIColor { get set }
    @objc optional var tintColor: UIColor { get }
    @objc optional var isTranslucent: Bool { get }
    @objc optional var barTitle: String { get }
    
}

class NavigationHandler: NSObject, UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool) {
        
        guard let modifier = viewController as? NavigationBarModifier else {
            return
        }
        
        if navigationController.isNavigationBarHidden != modifier.isNavigationBarHidden {
            navigationController.setNavigationBarHidden(modifier.isNavigationBarHidden, animated: animated)
        }
        
        if let barTintColor = modifier.barTintColor {
            navigationController.navigationBar.barTintColor = barTintColor
        }
        
        if let tintColor = modifier.tintColor {
            navigationController.navigationBar.tintColor = tintColor
        }
        
        if let isTranslucent = modifier.isTranslucent {
            navigationController.navigationBar.isTranslucent = isTranslucent
        }
        
        if let barTitle = modifier.barTitle {
            navigationController.navigationItem.title = barTitle
        }
    }
    
}
