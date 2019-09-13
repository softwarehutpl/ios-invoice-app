//
//  NewInvoiceViewModel.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 19/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit


class NewInvoiceViewModel: NewInvoiceViewModelType {
    
    // MARK: - Private
    private let sceneCoordinator: SceneCoordinatorType
    private let invoiceStorageService: InvoiceStorageServiceType
    
    
    // MARK: - Data From Cells
    private var invoiceFormModel: InvoiceFormModel?
    var clientModel: ClientModel?
    
    // MARK: - Lifecycle
    init(sceneCoordinator: SceneCoordinatorType, invoiceStorageService: InvoiceStorageServiceType) {
        self.sceneCoordinator = sceneCoordinator
        self.invoiceStorageService = invoiceStorageService
    }
}

extension NewInvoiceViewModel {
    
    func addInvoice(invoice: InvoiceModel) {
        invoiceStorageService.createInvoice(invoice: invoice)
    }
    
    func getClient() -> ClientModel?{
        return clientModel
    }
    
    // Invoice Form Data
    
    func getInvoiceFormModel(invoiceForm: InvoiceFormModel) {
        invoiceFormModel = invoiceForm
    }
    
    func createNewInvoice() {
        guard let invoice = invoiceFormModel, let client = clientModel else {
            print("Not all fields filled")
            return }
        let idFactory = UUID().uuidString
        let newInvoice = InvoiceModel(invoiceTitle: invoice.invoiceTitle,
                                      date: invoice.date,
                                      dueDate: invoice.dueDate,
                                      amount: invoice.amount,
                                      status: false, id: idFactory,
                                      client: client,
                                      items: [ItemModel(itemName: "testitem",
                                                        amount: "100",
                                                        price: "1000")])
        
        invoiceStorageService.createInvoice(invoice: newInvoice)
    }
    
    func getClientStatus() -> Bool {
       return clientModel == nil ? false : true
    }
    
    // Navigation
    func popToInvoiceList(source: UIViewController) {
        sceneCoordinator.pop(source: source, animated: true)
    }
    
    func selectClient(source: UIViewController) {
        sceneCoordinator.transition(to: StartupScene.clientsView(delegate: self), type: .push, source: source)
    }
}

extension NewInvoiceViewModel: ClientViewModelDelegate {
    func shareClient(client: ClientModel) {
        clientModel = client
    }
}


