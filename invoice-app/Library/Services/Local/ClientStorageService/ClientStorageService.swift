//
//  ClientStorageService.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 22/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation

class ClientStorageService: ClientStorageServiceType {
    
    let persistancemanager: PersistanceManager
    
    init(persistancemanager: PersistanceManager) {
        self.persistancemanager = persistancemanager
    }
}

extension ClientStorageService {
    func fetchClients() -> [ClientModel] {
        var clients = [ClientModel]()
        let clientsFromCoreData = persistancemanager.fetch(Client.self)
        clientsFromCoreData.forEach { (client) in
            let clientmodel = ClientModel(name: client.name, email: client.email, phone: client.phone, address: client.address, postcode: client.postcode, city: client.city, country: client.country)
            clients.append(clientmodel)
        }
        print("fetched")
        return clients
    }
    
    func addClient(client: ClientModel) {
        let clientToAdd = Client(context: persistancemanager.context)
        clientToAdd.name = client.name
        persistancemanager.save()
        print("saved")
    }
}
