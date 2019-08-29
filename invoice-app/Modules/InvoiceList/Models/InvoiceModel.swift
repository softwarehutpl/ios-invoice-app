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
    let dueDate: String
    let amount: String
    let status: Bool
    let client: ClientModel
    let items: [ItemModel]
}

struct ClientModel {
    var name: String
    var email: String
    var phone: String
    var address: String
    var postcode: String
    var city: String
    var country: String
}

struct ItemModel {
    let itemName: String
    let amount: String
    let price: String
}
