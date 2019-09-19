//
//  NewInvoiceViewModelType.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 19/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//
import UIKit

protocol NewInvoiceViewModelType {
    // Navigation
    func selectClient(source: UIViewController)
    func popToInvoiceList(source: UIViewController)
    func showNewItemView(source: UIViewController)
    
    // Fetching data from forms
    func addInvoice(invoice: InvoiceModel)
    func getInvoiceFormModel(invoiceForm: InvoiceFormModel)
    
    func createNewInvoice()
    func getClient() -> ClientModel?
    // Passing client to invoice view
    func getClientStatus() -> Bool
    
}
