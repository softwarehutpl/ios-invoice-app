//
//  InvoiceViewModelType.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 09/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

protocol InvoiceDetailViewModelType {
    func getCustomerDetails() -> Customer
    func getItemsDescriptions(indexPath: Int) -> ItemDescription
    func getItemsCount() -> Int
    func getDataForTopView() -> InvoiceModel
}
