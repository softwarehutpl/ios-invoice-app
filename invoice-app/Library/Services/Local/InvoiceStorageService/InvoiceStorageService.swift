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
    
    func createInvoice(invoice: InvoiceModel) {
        
        let invoiceToAdd = Invoice.create(context: persistanceManager.context, invoice: invoice)
        
        let clientsFromCoreData = persistanceManager.fetch(Client.self)
        let clientToConnectWithInvoice = clientsFromCoreData.first(where:{$0.id == invoice.client.id})
        guard let client = clientToConnectWithInvoice else { return }
        invoiceToAdd.client = client
        Item.create(context: persistanceManager.context, items: invoice.items, invoice: invoiceToAdd)
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
        return invoices
    }
    
    // Finding invoice which is matching ID to make operations.
    func findInvoice(invoice: InvoiceModel) -> Invoice? {
        let invoicesFromCoreData = persistanceManager.fetch(Invoice.self)
        let editingInvoice = invoicesFromCoreData.first(where: {$0.id == invoice.id})
        return editingInvoice
    }
    
    func compareItem(invoice: Invoice) -> [Item]? {
    var matchedItems = [Item]()
      let fetchedItems = persistanceManager.fetch(Item.self)
        for item in fetchedItems {
            if item.invoice == invoice {
            matchedItems.append(item)
            }
        }
        
      return matchedItems
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
        
        guard let items = compareItem(invoice: invoiceToEdit) else { return }
        items.forEach { (item) in
            persistanceManager.context.delete(item)
        }
        
        invoice.items.forEach { (item) in
            let itemToAdd = Item(context: persistanceManager.context)
            itemToAdd.itemName = item.itemName
            itemToAdd.amount = item.amount
            itemToAdd.price = item.price
            itemToAdd.id = item.id
            itemToAdd.tax = item.tax
            itemToAdd.invoice = invoiceToEdit
        }
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
