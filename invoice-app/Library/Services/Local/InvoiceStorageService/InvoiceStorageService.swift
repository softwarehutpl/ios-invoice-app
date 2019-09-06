//
//  InvoiceStorageService.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 27/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation

class InvoiceStorageService: InvoiceStorageServiceType {
    
    let persistanceManager: PersistanceManager
    
    init(persistanceManager: PersistanceManager) {
        self.persistanceManager = persistanceManager
    }
    
}

extension InvoiceStorageService {
    func createInvoice(invoice: InvoiceModel) {
        let invoiceToAdd = Invoice(context: persistanceManager.context)
        let client = Client(context: persistanceManager.context)
        invoiceToAdd.invoiceTitle = invoice.invoiceTitle
        invoiceToAdd.date = invoice.date
        invoiceToAdd.dueDate = invoice.dueDate
        invoiceToAdd.amount = invoice.amount
        invoiceToAdd.status = invoice.status
        
        client.name = invoice.client.name
        client.postcode = invoice.client.postcode
        client.email = invoice.client.email
        client.phone = invoice.client.phone
        client.address = invoice.client.address
        client.city = invoice.client.city
        client.country = invoice.client.country
        client.id = invoice.client.id
        
        invoiceToAdd.client = client
        persistanceManager.save()
        print("saved invoice")
    }
    
    func fetchInvoice() -> [InvoiceModel] {
        var invoices = [InvoiceModel]()
        let invoicesFromCoreData = persistanceManager.fetch(Invoice.self)
        invoicesFromCoreData.forEach { (invoice) in
            let invoice = InvoiceModel(invoiceTitle: invoice.invoiceTitle, date: invoice.date, dueDate: invoice.dueDate, amount: invoice.amount, status: true, client: ClientModel(name: invoice.client.name, email: invoice.client.email, phone: invoice.client.phone, address: invoice.client.address, postcode: invoice.client.postcode, city: invoice.client.city, country: invoice.client.country, id: invoice.client.id), items: [ItemModel(itemName: "item", amount: "1", price: "300")])
            invoices.append(invoice)
        }
        print("fetched invoices")
        return invoices
    }
    
}


