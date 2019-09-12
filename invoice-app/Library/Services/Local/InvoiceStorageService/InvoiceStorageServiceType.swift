//
//  InvoiceStorageServiceType.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 27/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

protocol InvoiceStorageServiceType {
    func fetchInvoice() -> [InvoiceModel]
    func createInvoice(invoice: InvoiceModel)
    func markAsPaid(invoice: InvoiceModel)
}
