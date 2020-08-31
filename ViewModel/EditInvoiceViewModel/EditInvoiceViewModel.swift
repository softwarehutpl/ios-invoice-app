//
//  EditInvoiceViewModel.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 14/10/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//
import UIKit

class EditInvoiceViewModel: EditInvoiceViewModelType  {
    
    //MARK: - Private
    private let invoiceStorageService: InvoiceStorageServiceType
    private let sceneCoordinator: SceneCoordinatorType
    private let invoice: InvoiceModel?
    private let formStatus: FormState
    
    init(sceneCoordinator: SceneCoordinatorType, invoiceStorageService: InvoiceStorageServiceType,
         invoice: InvoiceModel?, formStatus: FormState) {
        self.invoiceStorageService = invoiceStorageService
        self.sceneCoordinator = sceneCoordinator
        self.invoice = invoice
        self.formStatus = formStatus
    }
}

extension EditInvoiceViewModel {
    func editInvoice(invoice: InvoiceModel) {
        invoiceStorageService.editInvoice(invoice: invoice)
    }
    func getStatus() -> FormState {
        return formStatus
    }
}
