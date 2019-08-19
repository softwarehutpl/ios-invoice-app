//
//  CustomerDetails.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 13/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation

struct CustomerDetails {
    let name: String
    let email: String
    let phone: String
}

struct CustomerAddress {
    let address: String
}

struct ItemDescription {
    let itemName: String
    let amount: String
    let price: String
    let totalPrice: String
}
