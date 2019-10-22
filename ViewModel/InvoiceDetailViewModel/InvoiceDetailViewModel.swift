//
//  InvoiceDetailViewModel.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 09/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//


import UIKit

class InvoiceDetailViewModel: InvoiceDetailViewModelType {
    
    // MARK: - Private
    private let invoiceStorageService: InvoiceStorageServiceType
    private let sceneCoordinator: SceneCoordinatorType
    private let invoice: InvoiceModel
    
    // MARK: - Lifecycle
    init(sceneCoordinator: SceneCoordinatorType,invoice: InvoiceModel, invoiceStorageService: InvoiceStorageServiceType ) {
        self.sceneCoordinator = sceneCoordinator
        self.invoice = invoice
        self.invoiceStorageService = invoiceStorageService
    }
}

extension InvoiceDetailViewModel {
    
    func getCustomerDetails() -> ClientModel {
        let customerDetails = ClientModel(name: invoice.client.name, email: invoice.client.email, phone: invoice.client.phone, address: invoice.client.address, postcode: invoice.client.postcode, city: invoice.client.city, country: invoice.client.country, id: invoice.client.id)
        return customerDetails
    }
    
    func getDataForTopView() -> InvoiceModel {
        return invoice
    }
    
    func getItemsDescriptions(indexPath: Int) -> ItemModel {
        let items = invoice.items.map { (item) -> ItemModel in
            return item
        }
        return items[indexPath]
    }
    
    func getItemsCount() -> Int {
        return invoice.items.count
    }
    
    func deleteInvoice() {
        invoiceStorageService.deleteInvoice(invoice: self.invoice)
    }
    
    func popToInvoiceList(source: UIViewController) {
        sceneCoordinator.pop(source: source, animated: true)
    }
    func editInvoiceView(source: UIViewController) {
        sceneCoordinator.transition(to: StartupScene.newInvoice(invoice: invoice, formState: .editInvoice), type: .push, source: source)
    }
}
