//
//  ClientEditViewModelType.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 05/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation
import UIKit

protocol EditClientViewModelType {
    func fetchClientDetails() -> ClientDetailsModel
    func fetchClientAddressDetails() -> ClientAddressModel
    func editClient()
    func deleteClient()
    func popToClientList(source: UIViewController)
    func getEditedClientDetails(clientDetails: ClientDetailsModel)
    func getEditedClientAddress(clientAddress: ClientAddressModel)
}
