//
//  InvoiceModel.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 06/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//
//

struct InvoiceModel {
    var invoiceTitle: String
    var date: String
    var dueDate: String
    var amount: String
    var status: Bool
    var client: ClientModel
    var items: [ItemModel]
}

struct ItemModel {
    var itemName: String
    var amount: String
    var price: String
}