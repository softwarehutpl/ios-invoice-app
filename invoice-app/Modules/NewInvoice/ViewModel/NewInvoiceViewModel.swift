//
//  NewInvoiceViewModel.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 19/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class NewInvoiceViewModel {
    
    // MARK: - Private
    private let sceneCoordinator: SceneCoordinatorType
    
    // MARK: - Lifecycle
    init(sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
    }
    
}

extension NewInvoiceViewModel: NewInvoiceViewModelType {
    func addingNewClientView(source: UIViewController) {
        sceneCoordinator.transition(to: StartupScene.clientsView, type: .push, source: source )
    }
}
