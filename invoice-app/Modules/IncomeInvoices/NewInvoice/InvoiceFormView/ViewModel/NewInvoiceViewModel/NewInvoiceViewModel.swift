//
//  NewInvoiceViewModel.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 19/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class NewInvoiceViewModel: NewInvoiceViewModelType {
    
    let validator = Validation()
    
    // MARK: - Private
    private let sceneCoordinator: SceneCoordinatorType
    private let invoiceStorageService: InvoiceStorageServiceType
    private var formState: FormState
    var invoiceModel: InvoiceModel?
    
    // MARK: - Data From Cells
    var invoiceFormData: InvoiceFormModel?
    var clientFormData: ClientModel?
    var itemsFormData = [ItemModel(itemName: "", amount: "", price: "", tax: "", id: ""),
                         ItemModel(itemName: "", amount: "", price: "", tax: "", id: "")]
    
    // MARK: - Lifecycle
    init(sceneCoordinator: SceneCoordinatorType, invoiceStorageService: InvoiceStorageServiceType, invoiceModel: InvoiceModel?, formState: FormState) {
        self.sceneCoordinator = sceneCoordinator
        self.invoiceStorageService = invoiceStorageService
        self.formState = formState
        self.invoiceModel = invoiceModel
    }
}

extension NewInvoiceViewModel {

    
    // Setting view depending on whether client is selected
    func getFormState() -> FormState {
        return formState
    }
    
    func getClientTest() -> Bool {
        return clientFormData != nil
    }
    
    // Navigation
    func selectClient(source: UIViewController) {
        sceneCoordinator.transition(to: StartupScene.clientsView(delegate: self, listState: .selectingClientToInvoice), type: .push, source: source)
    }
    func popToInvoiceList(source: UIViewController) {
        sceneCoordinator.pop(source: source, animated: true)
    }
    
    // Fetching data from forms
    func fetchClientForm() -> ClientModel?{
        return clientFormData
    }
    func fetchInvoiceForm(invoiceForm: InvoiceFormModel,source: UIViewController) {
        let validate = validator.validate(values: (type: ValidationType.title, inputValue: invoiceForm.invoiceTitle), target: source)
        switch validate {
        case .success:
            invoiceFormData = invoiceForm
        case .failure:
            print("")
        }
    }
    func fetchItemsForm(itemModel: ItemModel,index: Int) {
        if itemsFormData.isEmpty {
            itemsFormData.append(itemModel)
        } else {
            let indexIsValid = itemsFormData.indices.contains(index)
//            if itemsFormData.contains(where: {$0.id != itemModel.id}) {
                indexIsValid == true ? itemsFormData[index] = itemModel : itemsFormData.append(itemModel)
//            }
        }
    }
    
    // Creating Invoice
    func createNewInvoice() {
        guard let invoice = invoiceFormData, let client = clientFormData else { return }
        let idFactory = UUID().uuidString
        let itemsToAdd = itemsFormData.filter({$0.itemName != ""})
        
        invoiceModel = InvoiceModel(invoiceTitle: invoice.invoiceTitle,
                                      date: invoice.date,
                                      dueDate: invoice.dueDate,
                                      currency: invoice.currency,
                                      paymentMethod: invoice.paymentMethod,
                                      status: false, id: idFactory,
                                      client: client,
                                      items: itemsToAdd)
        guard let invoiceToPass = invoiceModel else { return }
        if formState == .clientSelected {
            invoiceStorageService.createInvoice(invoice: invoiceToPass)
        } else {
            invoiceStorageService.editInvoice(invoice: invoiceToPass)
        }
    }
    
    func editInvoice() {
        guard let invoice = invoiceFormData, let client = clientFormData else { return }
        let itemsToAdd = itemsFormData.filter({$0.itemName != ""})
        invoiceModel = InvoiceModel(invoiceTitle: invoice.invoiceTitle,
                                    date: invoice.date,
                                    dueDate: invoice.dueDate,
                                    currency: invoice.currency,
                                    paymentMethod: invoice.paymentMethod,
                                    status: false, id: invoiceModel?.id ?? "",
                                    client: client,
                                    items: itemsToAdd)
        guard let invoiceToPass = invoiceModel else { return }
        invoiceStorageService.editInvoice(invoice: invoiceToPass)
    }
     // Showing fetched items in form
    
    func fillFormsFromEditView() {
        guard let invoice = invoiceModel else { return }
        invoiceFormData = InvoiceFormModel(invoiceTitle: invoice.invoiceTitle, date: invoice.date, dueDate: invoice.dueDate, paymentMethod: invoice.paymentMethod, currency: invoice.currency)
        clientFormData = invoice.client
        itemsFormData = invoice.items
        itemsFormData.append(ItemModel(itemName: "", amount: "", price: "", tax: "", id: ""))
    }
    
    func passItemsToSection(indexPath: Int) -> ItemModel {
        return itemsFormData[indexPath]
    }
    
    func passInvoiceFormToSection() -> InvoiceFormModel {
        if let invoice = invoiceFormData {
        let invoiceForm = InvoiceFormModel(invoiceTitle: invoice.invoiceTitle, date: invoice.date
            , dueDate: invoice.dueDate, paymentMethod: invoice.paymentMethod, currency: invoice.currency)
        return invoiceForm
        }
        return InvoiceFormModel(invoiceTitle: "", date: "", dueDate: "", paymentMethod: "", currency: "")
        
    }
    func addEmptyRow() {
        itemsFormData.append(ItemModel(itemName: "", amount: "", price: "", tax: "", id: ""))
    }
    
    func itemsCount() -> Int {
        return itemsFormData.count
    }
    
    // Delete item from form
    func deleteItemFromForm(indexPath: Int) {
        if itemsFormData.count > 2 {
        itemsFormData.remove(at: indexPath)
        } else {
            print("cant delete object")
        }
    }
    
    // Adding Empty Row
    func addRow(nrOfRows: Int) {
        var items = [ItemModel]()
        for _ in 0...nrOfRows {
            let item = ItemModel(itemName: "", amount: "", price: "", tax: "", id: "")
            items.append(item)
        }
        itemsFormData = items
    }
}

extension NewInvoiceViewModel: ClientViewModelDelegate {
    func passFormState(formState: FormState) {
        self.formState = formState
    }
    
    func shareClient(client: ClientModel) {
        clientFormData = client
    }
}


