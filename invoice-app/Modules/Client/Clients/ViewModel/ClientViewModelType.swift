//
//  NewClientViewType.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 22/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

protocol ClientViewModelType {
    var delegate: ClientViewModelDelegate { get set }
    // Operations on Core Data
    func createNewClient(source: UIViewController)
    func fetchClientsFromCoreData()
    func getClientsCount() -> Int
    func fetchClients(index: Int) -> ClientModel
    func passClientToNewInvoiceView(client: ClientModel)
    func passFormStateToInvoiceView(formState: FormState)
    func searchClient(searchClient: String)
    // Navigation
    func popToNewInvoiceView(source: UIViewController)
    func pushToEditClientView(source: UIViewController, client: ClientModel)
}
