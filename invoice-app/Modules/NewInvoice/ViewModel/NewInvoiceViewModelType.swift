//
//  NewInvoiceViewModelType.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 19/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//
import UIKit

protocol NewInvoiceViewModelType {
    func selectClient(source: UIViewController)
    func addInvoice(invoice: InvoiceModel)
}