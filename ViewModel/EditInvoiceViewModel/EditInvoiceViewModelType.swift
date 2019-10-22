//
//  EditInvoiceViewModelType.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 14/10/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation

protocol EditInvoiceViewModelType {
    func getStatus() -> FormState
    func editInvoice(invoice: InvoiceModel)
}
