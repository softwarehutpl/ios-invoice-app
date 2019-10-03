//
//  NewInvoiceViewModelType.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 19/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//
import UIKit

protocol NewInvoiceViewModelType {
    
    // Setting view depending on whether client is selected
    func getClientStatus() -> Bool
    
    // Navigation
    func selectClient(source: UIViewController)
    func popToInvoiceList(source: UIViewController)
    func showNewItemView(source: UIViewController)
    
    // Fetching data from forms
    func getInvoiceFormModel(invoiceForm: InvoiceFormModel)
    func getItemFormModel(itemModel: ItemModel)
    
    // Creating Invoice
    func checkInvoiceElements(source: UIViewController)
    func createNewInvoice()
    
    // Showing fetched client in form
    func getClient() -> ClientModel?
    
    func checkInvoiceForm(invoiceForm: InvoiceFormModel,source: UIViewController)
    }

