//
//  File.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 26/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation



class NewClientModel {
    var clientDetails: ClientDetailsCellModel
    var clientAddress: ClientAddressCellModel
    
    init(clientDetails: ClientDetailsCellModel, clientAddress: ClientAddressCellModel) {
        self.clientDetails = clientDetails
        self.clientAddress = clientAddress
    }
}


class ClientDetailsCellModel {
    let name: String
    let email: String
    let phone: String
    
    init(name: String, email: String, phone: String) {
        self.name = name
        self.email = email
        self.phone = phone
    }
}

class ClientAddressCellModel {
    let address: String
    let postcode: String
    let city: String
    let country: String
    
    init(address:String, postcode: String, city: String, country: String) {
        self.address = address
        self.postcode = postcode
        self.city = city
        self.country = country
    }
}


