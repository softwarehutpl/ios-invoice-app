//
//  NewInvoiceViewModel.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 19/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class NewInvoiceViewModel {
    
    // MARK: - Private
    private let sceneCoordinator: SceneCoordinatorType
    private let invoiceStorageService: InvoiceStorageServiceType
    
    // MARK: - Lifecycle
    init(sceneCoordinator: SceneCoordinatorType, invoiceStorageService: InvoiceStorageServiceType) {
        self.sceneCoordinator = sceneCoordinator
        self.invoiceStorageService = invoiceStorageService
    }
    
}

extension NewInvoiceViewModel: NewInvoiceViewModelType {
    func selectClient(source: UIViewController) {
        sceneCoordinator.transition(to: StartupScene.clientsView, type: .push, source: source )
    }
    func addInvoice(invoice: InvoiceModel) {
        invoiceStorageService.createInvoice(invoice: invoice)
    }
}
