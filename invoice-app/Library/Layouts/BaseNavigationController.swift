//
//  BaseNavigationController.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 02/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Methods
    /// Setups all views
    private func setup() {
        navigationBar.isHidden = true
    }
}

// MARK: - Extension with Constants
private extension BaseNavigationController {
    
    // MARK: - Colors
    struct Colors {
        
        private init() { }
        static let navigationBarTint: UIColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
    }
    
}
