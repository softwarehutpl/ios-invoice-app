//
//  ClientStorageService.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 22/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation

class ClientStorageService: ClientStorageServiceType {
    
    let persistanceManager: PersistanceManager
    
    init(persistanceManager: PersistanceManager) {
        self.persistanceManager = persistanceManager
    }
}

extension ClientStorageService {
    
    func addClient(client: ClientModel) {
        let clientToAdd = Client(context: persistanceManager.context)
        clientToAdd.name = client.name
        clientToAdd.email = client.email
        clientToAdd.phone = client.phone
        clientToAdd.address = client.address
        clientToAdd.postcode = client.postcode
        clientToAdd.city = client.city
        clientToAdd.country = client.country
        persistanceManager.save()
        print("saved client")
    }
    
    func fetchClients() -> [ClientModel] {
        var clients = [ClientModel]()
        let clientsFromCoreData = persistanceManager.fetch(Client.self)
        clientsFromCoreData.forEach { (client) in
            let clientmodel = ClientModel(name: client.name, email: client.email, phone: client.phone, address: client.address, postcode: client.postcode, city: client.city, country: client.country)
            clients.append(clientmodel)
        }
        print("fetched clients")
        return clients
    }
    
}