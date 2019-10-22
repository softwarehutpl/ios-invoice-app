//
//  InvoiceStorageService.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 27/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation
import CoreData

class InvoiceStorageService: InvoiceStorageServiceType {
    
    let persistanceManager: PersistanceManager
    
    init(persistanceManager: PersistanceManager) {
        self.persistanceManager = persistanceManager
    }
}

extension InvoiceStorageService {
    
    func clearData() {
        let items = Item(context: persistanceManager.context)
        persistanceManager.context.delete(items)
    }
    
    func createInvoice(invoice: InvoiceModel) {
        
        let invoiceToAdd = Invoice(context: persistanceManager.context)
        
        invoiceToAdd.invoiceTitle = invoice.invoiceTitle
        invoiceToAdd.date = invoice.date
        invoiceToAdd.dueDate = invoice.dueDate
        invoiceToAdd.currency = invoice.currency
        invoiceToAdd.paymentMethod = invoice.paymentMethod
        invoiceToAdd.id = invoice.id
        invoiceToAdd.status = invoice.status
        
        let clientsFromCoreData = persistanceManager.fetch(Client.self)
        let clientToConnectWithInvoice = clientsFromCoreData.first(where:{$0.id == invoice.client.id})
        guard let client = clientToConnectWithInvoice else { return }
        invoiceToAdd.client = client
        
        invoice.items.forEach { (item) in
            let itemToConnect = Item(context: persistanceManager.context)
            itemToConnect.itemName = item.itemName
            itemToConnect.amount = item.amount
            itemToConnect.price = item.price
            itemToConnect.tax = item.tax
            itemToConnect.id = item.id
            itemToConnect.invoice = invoiceToAdd
            print("saved invoice")
        }
        persistanceManager.save()
    }
    
    func fetchInvoice() -> [InvoiceModel] {
        
        var invoices = [InvoiceModel]()
        let invoicesFromCoreData = persistanceManager.fetch(Invoice.self)
        
        invoicesFromCoreData.forEach { (invoice) in
            var itemsModel = [ItemModel]()
            for case let item as Item in invoice.items {
                let itemModel = ItemModel(itemName: item.itemName, amount: item.amount, price: item.price, tax: item.tax, id: item.id)
                itemsModel.append(itemModel)
            }
            
            let invoiceModel = InvoiceModel(invoiceTitle: invoice.invoiceTitle, date: invoice.date, dueDate: invoice.dueDate, currency: invoice.currency, paymentMethod: invoice.paymentMethod, status: invoice.status, id: invoice.id, client: ClientModel(name: invoice.client.name, email: invoice.client.email, phone: invoice.client.phone, address: invoice.client.address, postcode: invoice.client.postcode, city: invoice.client.city, country: invoice.client.country, id: invoice.client.id),items: itemsModel)
            invoices.append(invoiceModel)
        }
        print("fetched invoices")
        return invoices
    }
    
    // Finding invoice which is matching ID to make operations.
    func findInvoice(invoice: InvoiceModel) -> Invoice? {
        let invoicesFromCoreData = persistanceManager.fetch(Invoice.self)
        let editingInvoice = invoicesFromCoreData.first(where: {$0.id == invoice.id})
        return editingInvoice
    }
    
    func compareItem(invoice: Invoice) -> [Item] {
        let items = persistanceManager.fetch(Item.self)
        let invoiceConnected = items.filter({$0.invoice == invoice})
        return invoiceConnected
    }
    
    func editInvoice(invoice: InvoiceModel) {
        guard let invoiceToEdit = findInvoice(invoice: invoice) else { return }
        invoiceToEdit.invoiceTitle = invoice.invoiceTitle
        invoiceToEdit.date = invoice.date
        invoiceToEdit.dueDate = invoice.dueDate
        invoiceToEdit.currency = invoice.currency
        invoiceToEdit.id = invoice.id
        invoiceToEdit.status = invoice.status
        invoiceToEdit.paymentMethod = invoice.paymentMethod
        
        let clientsFromCoreData = persistanceManager.fetch(Client.self)
        let clientToConnectWithInvoice = clientsFromCoreData.first(where:{$0.id == invoice.client.id})
        guard let client = clientToConnectWithInvoice else { return }
        invoiceToEdit.client = client
        
        let itemsToEdit = compareItem(invoice: invoiceToEdit)
        
        
        invoice.items.forEach { (item) in
            itemsToEdit.forEach { (itemToEdit) in
                if itemToEdit.id == item.id {
                   itemToEdit.itemName = item.itemName
                   itemToEdit.price = item.price
                   itemToEdit.id = item.id
                   itemToEdit.amount = item.amount
                   itemToEdit.tax = item.tax
                }
            }
        }
        print(invoiceToEdit.items)
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
