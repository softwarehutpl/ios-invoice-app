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
    
    func getCustomerDetails() -> Customer {
        let customerDetails = Customer(name: invoice.customer.name, email: invoice.customer.email, phone: invoice.customer.phone, address: invoice.customer.address)
        return customerDetails
    }
    
    func getTopViewData() -> TopViewData {
        let topviewdata = TopViewData(amount: invoice.amount, date: invoice.date)
        return topviewdata
    }
    
    func getItemsDescriptions(indexPath: Int) -> ItemDescription {
        let items = invoice.itemDescription.map { (item) -> ItemDescription in
            return item
        }
        return items[indexPath]
    }
    
    func getItemsCount() -> Int {
        return invoice.itemDescription.count
    }
}
