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
        
        invoiceToAdd.invoiceTitle = invoice.invoiceTitle
        invoiceToAdd.date = invoice.date
        invoiceToAdd.dueDate = invoice.dueDate
        invoiceToAdd.amount = invoice.amount
        invoiceToAdd.id = invoice.id
        invoiceToAdd.status = invoice.status
        
        let clientsFromCoreData = persistanceManager.fetch(Client.self)
        let clientToConnectWithInvoice = clientsFromCoreData.first(where:{$0.id == invoice.client.id})
        
        guard let client = clientToConnectWithInvoice else { return }
        invoiceToAdd.client = client
        persistanceManager.save()
        print("saved invoice")
    }
    
    func fetchInvoice() -> [InvoiceModel] {
        var invoices = [InvoiceModel]()
        let invoicesFromCoreData = persistanceManager.fetch(Invoice.self)
        invoicesFromCoreData.forEach { (invoice) in
            let invoice = InvoiceModel(invoiceTitle: invoice.invoiceTitle, date: invoice.date, dueDate: invoice.dueDate, amount: invoice.amount, status: true, id: invoice.id, client: ClientModel(name: invoice.client.name, email: invoice.client.email, phone: invoice.client.phone, address: invoice.client.address, postcode: invoice.client.postcode, city: invoice.client.city, country: invoice.client.country, id: invoice.client.id), items: [ItemModel(itemName: "item", amount: "1", price: "300")])
            invoices.append(invoice)
        }
        return invoices
    }
    
    // Finding invoice which is matching ID to make operations.
    func findInvoice(invoice: InvoiceModel) -> Invoice? {
        let invoicesFromCoreData = persistanceManager.fetch(Invoice.self)
        let editingInvoice = invoicesFromCoreData.first(where: {$0.id == invoice.id})
        return editingInvoice
    }
    
    func editInvoice(invoice: InvoiceModel) {
        guard let invoiceToEdit = findInvoice(invoice: invoice) else { return }
        invoiceToEdit.invoiceTitle = invoice.invoiceTitle
        invoiceToEdit.date = invoice.date
        invoiceToEdit.dueDate = invoice.dueDate
        invoiceToEdit.amount = invoice.amount
        invoiceToEdit.id = invoice.id
        invoiceToEdit.status = invoice.status
        persistanceManager.save()
    }
    
    func deleteInvoice(invoice: InvoiceModel) {
        guard let invoiceToDelete = findInvoice(invoice: invoice) else { return }
        persistanceManager.context.delete(invoiceToDelete)
        persistanceManager.save()
    }
    
    func changeInvoiceStatus(invoice: InvoiceModel) {
        guard let invoiceToChangeStatus = findInvoice(invoice: invoice) else { return }
        invoiceToChangeStatus.status = invoice.status
        persistanceManager.save()
    }
}


