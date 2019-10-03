//
//  NewItemViewModel.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 19/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class NewItemViewModel: NewItemViewModelType {
    
    private let sceneCoordinator: SceneCoordinatorType
    
    init(sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
    }
}

extension NewItemViewModel {
    func popToNewInvoiceForm(source: UIViewController) {
        sceneCoordinator.pop(source: source, animated: true)
    }
}
