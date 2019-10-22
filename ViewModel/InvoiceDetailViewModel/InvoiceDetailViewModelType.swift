//
//  InvoiceViewModelType.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 09/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

protocol InvoiceDetailViewModelType {
    func getCustomerDetails() -> ClientModel
    func getItemsDescriptions(indexPath: Int) -> ItemModel
    func getItemsCount() -> Int
    func getDataForTopView() -> InvoiceModel
    func deleteInvoice()
    // Navigation
    func popToInvoiceList(source: UIViewController)
    func editInvoiceView(source: UIViewController)
}
