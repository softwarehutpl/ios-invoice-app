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
    func getFormState() -> FormState
    
    // Navigation
    func selectClient(source: UIViewController)
    func popToInvoiceList(source: UIViewController)
    
    // Fetching data from forms
    func fetchClientForm() -> ClientModel?
    func fetchInvoiceForm(invoiceForm: InvoiceFormModel, source: UIViewController)
    func fetchItemsForm(itemModel: ItemModel, index: Int)
    
    // Creating Invoice
    func createNewInvoice()
    func editInvoice()
    
    // Showing fetched client in form
    
    
    // Showing data from viewModel in items section
    func addEmptyRow()
    func passInvoiceFormToSection() -> InvoiceFormModel
    func passItemsToSection(indexPath: Int) -> ItemModel
    func itemsCount() -> Int
    
    //Deleting rows
    func deleteItemFromForm(indexPath: Int)
    
    func addRow(nrOfRows: Int)
    
    
    func getClientTest() -> Bool
    
    func fillFormsFromEditView()
}
