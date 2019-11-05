//
//  BaseTabBarController.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 23/10/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation
import UIKit

class BaseTabBarController: UITabBarController {
        
    private let resolver: ViewControllerResolverType
    private let viewModel: BaseTabBarViewModelType
    
    
    init(viewModel: BaseTabBarViewModelType,resolver: ViewControllerResolverType) {
        self.viewModel = viewModel
        self.resolver = resolver
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
    func setupTabBarController() {
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.02818264812, green: 0.4560676217, blue: 0.3500111699, alpha: 0.6357823202)
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.02818264812, green: 0.4560676217, blue: 0.3500111699, alpha: 1)
        tabBar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tabBar.isTranslucent = false
        
        // MARK: Views in tabbar
        let overview = createViewController(vc: resolver.overViewViewController()!,
                                            image: #imageLiteral(resourceName: "overview"),
                                            title: "Overview")
        let incomeInvoices = createViewController(vc: resolver.invoiceListController()!,
                                              image: #imageLiteral(resourceName: "invoices"),
                                              title: "Income")
        let expensesInvoices = createViewController(vc: UIViewController(),
        image: #imageLiteral(resourceName: "invoices"),
        title: "Expenses")
        
        let clients = createViewController(vc: resolver.clientsViewControler(delegate: nil, listState: .none)!,
                                             image: #imageLiteral(resourceName: "clients"),
                                             title: "Clients")
        
        let profile = createViewController(vc: resolver.profileViewController()!,
                                      image: #imageLiteral(resourceName: "profile"),
                                      title: "Profile")
        
        viewControllers = [overview, incomeInvoices,expensesInvoices, clients, profile]
    }
}

extension UITabBarController {
    func createViewController(vc: UIViewController, image: UIImage, title: String) -> UINavigationController {
        let viewController = vc
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = image
        navController.title = title
        navController.navigationBar.tintColor = .white
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        navController.navigationBar.barTintColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
        navController.navigationBar.barStyle = .black
        return navController
    }
}
