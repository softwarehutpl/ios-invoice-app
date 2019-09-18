//
//  NewClientViewModel.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 22/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class ClientViewModel: ClientViewModelType {
    
    // MARK: - Private
    private var clients = [ClientModel]()
    private let clientStorageService: ClientStorageServiceType
    private let sceneCoordinator: SceneCoordinatorType
    
    // MARK: - Lifecycle
    init(sceneCoordinator: SceneCoordinatorType, clientStorageService: ClientStorageServiceType) {
        self.sceneCoordinator = sceneCoordinator
        self.clientStorageService = clientStorageService
    }
}

extension ClientViewModel {
    func createNewClient(source: UIViewController) {
        sceneCoordinator.transition(to: StartupScene.newClientView, type: .push, source: source)
    }
    func fetchClients(index: Int) -> ClientModel {
        return clients[index]
    }
    
    func fetchClientsFromCoreData() {
        self.clients = clientStorageService.fetchClients()
    }
    
    func getClientCount() -> Int {
       return clients.count
    }
    
}