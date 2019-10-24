//
//  BaseTabBarViewModel.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 23/10/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation
import UIKit

class BaseTabBarViewModel: BaseTabBarViewModelType {

    
    private let sceneCoordinator: SceneCoordinatorType
    
    init(sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
    }
}

extension BaseTabBarViewModel {
}
