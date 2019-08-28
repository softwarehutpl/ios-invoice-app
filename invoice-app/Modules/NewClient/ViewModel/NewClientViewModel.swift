//
//  NewClientViewModel.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 22/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NewClientViewModel: NewClientViewModelType {

    // MARK: - Private
    
    private let sceneCoordinator: SceneCoordinatorType
    private let clientStorageService: ClientStorageServiceType
    
    // MARK: - Lifecycle
    init(sceneCoordinator: SceneCoordinatorType, clientStorageService: ClientStorageServiceType) {
        self.sceneCoordinator = sceneCoordinator
        self.clientStorageService = clientStorageService
    }
}

extension NewClientViewModel {
    func createNewClient(client: ClientModel, source: UIViewController) {
        clientStorageService.addClient(client: client)
        sceneCoordinator.pop(source: source , animated: true)
    }
}
