//
//  NewClientViewType.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 22/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

protocol ClientViewModelType {
    func createNewClient(source: UIViewController)
    func fetchClientsFromCoreData()
    func getClientCount() -> Int
    func fetchClients(index: Int) -> ClientModel
}
