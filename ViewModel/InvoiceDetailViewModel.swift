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
        private let sceneCoordinator: SceneCoordinatorType
        private let invoice: InvoiceModel
        
        // MARK: - Lifecycle
        init(sceneCoordinator: SceneCoordinatorType,invoice: InvoiceModel) {
            self.sceneCoordinator = sceneCoordinator
            self.invoice = invoice
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
}
