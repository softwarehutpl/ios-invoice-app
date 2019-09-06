//
//  EditClientViewModel.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 05/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation
import UIKit

class EditClientViewModel: EditClientViewModelType {
    
    //MARK: - Propierties
    var client: ClientModel
    

    //MARK: - Private
    private let sceneCoordinator: SceneCoordinatorType
    private let clientStorageService: ClientStorageServiceType
    
    private var editedClientDetails: ClientDetailsModel?
    private var editedClientAddress: ClientAddressModel?
    
    //MARK: - Inits
    init(sceneCoordinator: SceneCoordinatorType, clientStorageService: ClientStorageServiceType,client: ClientModel) {
        self.sceneCoordinator = sceneCoordinator
        self.clientStorageService = clientStorageService
        self.client = client
    }
}

extension EditClientViewModel {
    func fetchClientDetails() -> ClientDetailsModel {
        let clientDetails = ClientDetailsModel(name: client.name, email: client.email, phone: client.phone)
        return clientDetails
    }
    func fetchClientAddressDetails() -> ClientAddressModel {
        let clientAddress = ClientAddressModel(address: client.address, postcode: client.postcode, city: client.city
            , country: client.country)
        return clientAddress
    }
    func getClientData() -> String {
        return client.id
    }
    func editClient() {
        clientStorageService.editClient(client: client)
    }
    func popToClientList(source: UIViewController) {
        sceneCoordinator.pop(source: source, animated: true)
    }
    func getEditedClientDetails(clientDetails: ClientDetailsModel) {
        self.client.name = clientDetails.name
        self.client.email = clientDetails.email
        self.client.phone = clientDetails.phone
    }
    func getEditedClientAddress(clientAddress: ClientAddressModel) {
        self.client.address = clientAddress.address
        self.client.postcode = clientAddress.postcode
        self.client.city = clientAddress.city
        self.client.country = clientAddress.country
    }
}

