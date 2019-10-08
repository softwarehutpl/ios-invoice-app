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
    private var invoiceFormData: InvoiceFormModel?
    var clientFormData: ClientModel?
    var itemsFormData = [ItemModel]()
    
    // MARK: - Lifecycle
    init(sceneCoordinator: SceneCoordinatorType, invoiceStorageService: InvoiceStorageServiceType) {
        self.sceneCoordinator = sceneCoordinator
        self.invoiceStorageService = invoiceStorageService
    }
}

extension NewInvoiceViewModel {
    
    // Setting view depending on whether client is selected
    func getClientStatus() -> Bool {
        return clientFormData == nil ? false : true
    }
    
    // Navigation
    func selectClient(source: UIViewController) {
        sceneCoordinator.transition(to: StartupScene.clientsView(delegate: self), type: .push, source: source)
    }
    func popToInvoiceList(source: UIViewController) {
        sceneCoordinator.pop(source: source, animated: true)
    }
    
    // Fetching data from forms
    
    func checkInvoiceForm(invoiceForm: InvoiceFormModel,source: UIViewController) {
        let validate = validator.validate(values: (type: ValidationType.title, inputValue: invoiceForm.invoiceTitle), target: source)
        switch validate {
        case .success:
            invoiceFormData = invoiceForm
            print(invoiceFormData)
        case .failure:
            print("")
        }
    }
    
    func getItemFormModel(itemModel: ItemModel,index: Int) {
        if itemsFormData.isEmpty {
            itemsFormData.append(itemModel)
        } else {
            let indexIsValid = itemsFormData.indices.contains(index)
            indexIsValid == true ? itemsFormData[index] = itemModel : itemsFormData.append(itemModel)
        }
    }
    
    // Creating Invoice
    func createNewInvoice() {
        guard let invoice = invoiceFormData, let client = clientFormData else { return }
        
        let idFactory = UUID().uuidString
        let newInvoice = InvoiceModel(invoiceTitle: invoice.invoiceTitle,
                                      date: invoice.date,
                                      dueDate: invoice.dueDate,
                                      amount: invoice.paymentMethod,
                                      status: false, id: idFactory,
                                      client: client,
                                      items: itemsFormData)
        print(newInvoice)
        invoiceStorageService.createInvoice(invoice: newInvoice)
    }
    
    // Showing fetched client in form
    func getClient() -> ClientModel?{
        return clientFormData
    }
    
    func showNewItemView(source: UIViewController) {
    }
}

extension NewInvoiceViewModel: ClientViewModelDelegate {
    func shareClient(client: ClientModel) {
        clientFormData = client
    }
}


