//
//  InvoiceModel.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 06/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//
//

struct InvoiceModel {
    let invoiceTitle: String
    let date: String
    let amount: String
    let status: Bool
    let customer: Customer
    let itemDescription: [ItemDescription]
}

struct Customer {
    let name: String
    let email: String
    let phone: String
    let address: String
}

struct TopViewData {
    let amount: String
    let date: String
}

struct ItemDescription {
    let itemName: String
    let amount: String
    let price: String
}
