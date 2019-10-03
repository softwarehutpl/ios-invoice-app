//
//  NewInvoiceViewModel.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 19/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class NewInvoiceViewModel: NewInvoiceViewModelType {
    
    let validator = Validation()
    
    // MARK: - Private
    private let sceneCoordinator: SceneCoordinatorType
    private let invoiceStorageService: InvoiceStorageServiceType
    
    
    // MARK: - Data From Cells
    private var invoiceFormModel: InvoiceFormModel?
    var clientModel: ClientModel?
    var items: [ItemModel]?
    
    // MARK: - Lifecycle
    init(sceneCoordinator: SceneCoordinatorType, invoiceStorageService: InvoiceStorageServiceType) {
        self.sceneCoordinator = sceneCoordinator
        self.invoiceStorageService = invoiceStorageService
    }
}

extension NewInvoiceViewModel {
    
    // Setting view depending on whether client is selected
    func getClientStatus() -> Bool {
        return clientModel == nil ? false : true
    }
    
    // Navigation
    func selectClient(source: UIViewController) {
        sceneCoordinator.transition(to: StartupScene.clientsView(delegate: self), type: .push, source: source)
    }
    func popToInvoiceList(source: UIViewController) {
        sceneCoordinator.pop(source: source, animated: true)
    }
    
    // Fetching data from forms
    func getInvoiceFormModel(invoiceForm: InvoiceFormModel) {
        invoiceFormModel = invoiceForm
    }
    func getItemFormModel(itemModel: ItemModel) {
        items?.append(itemModel)
    }
    
    // Creating invoice
    func checkInvoiceElements(source: UIViewController) {
           
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
    
    // Showing fetched client in form
    func getClient() -> ClientModel?{
        return clientModel
    }
    func showNewItemView(source: UIViewController) {
    }
    
    
    func checkInvoiceForm(invoiceForm: InvoiceFormModel,source: UIViewController) {
        let validate = validator.validate(values: (type: ValidationType.email, inputValue: invoiceForm.invoiceTitle), target: source)
        switch validate {
        case .success:
            invoiceFormModel = invoiceForm
        case .failure:
            print("failed")
        }
    }
}

extension NewInvoiceViewModel: ClientViewModelDelegate {
    func shareClient(client: ClientModel) {
        clientModel = client
    }
}


