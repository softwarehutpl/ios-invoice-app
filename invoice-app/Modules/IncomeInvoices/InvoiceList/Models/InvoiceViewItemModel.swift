//
//  InvoiceViewItemModel.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 26/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation

struct ItemModel: Equatable {
    var itemName: String
    var amount: String
    var price: String
    var tax: String
    var id: String
}
