//
//  ClientStorageServiceType.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 22/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

protocol ClientStorageServiceType {
    func fetchClients() -> [ClientModel]
    func addClient(client: ClientModel)
    func editClient(client: ClientModel)
    func deleteClient(client: ClientModel)
}
