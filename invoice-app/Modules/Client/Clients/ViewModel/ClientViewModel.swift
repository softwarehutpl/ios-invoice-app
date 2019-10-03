//
//  NewClientViewModel.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 22/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

protocol ClientViewModelDelegate: AnyObject {
    func shareClient(client: ClientModel)
}

class ClientViewModel: ClientViewModelType {
    
    // MARK: - Private
    var delegate: ClientViewModelDelegate
    
    private let clientStorageService: ClientStorageServiceType
    private let sceneCoordinator: SceneCoordinatorType
    
    private var clients = [ClientModel]()
    private var clientsToShow = [ClientModel]()
    private var searchingClient: String = "" {
        didSet {
            if searchingClient.isEmpty  {
                clientsToShow = clients
            } else {
            clientsToShow.removeAll()
            clientsToShow.append(contentsOf: clients.filter({$0.name.lowercased().contains(searchingClient.lowercased())}))
            }
        }
    }
    
    // MARK: - Lifecycle
    init(sceneCoordinator: SceneCoordinatorType, clientStorageService: ClientStorageServiceType,delegate: ClientViewModelDelegate) {
        self.sceneCoordinator = sceneCoordinator
        self.clientStorageService = clientStorageService
        self.delegate = delegate
    }
}

extension ClientViewModel  {
    
    // Operations on Core Data
    func createNewClient(source: UIViewController) {
        sceneCoordinator.transition(to: StartupScene.newClientView, type: .push, source: source)
    }
    
    func fetchClients(index: Int) -> ClientModel {
        return clientsToShow[index]
    }
    
    func fetchClientsFromCoreData() {
        self.clients = clientStorageService.fetchClients()
        clientsToShow = clients
    }
    
    func getClientsCount() -> Int {
        return clientsToShow.count
    }
    
    // Navigation
    func popToNewInvoiceView(source: UIViewController) {
        sceneCoordinator.pop(source: source, animated: true)
    }
    func passClientToNewInvoiceView(client: ClientModel) {
        delegate.shareClient(client: client)
    }
    
    func pushToEditClientView(source: UIViewController, client: ClientModel) {
        sceneCoordinator.transition(to: StartupScene.editClientView(client: client), type: .push, source: source)
    }
    
    func searchClient(searchClient: String) {
        searchingClient = searchClient
    }
}
