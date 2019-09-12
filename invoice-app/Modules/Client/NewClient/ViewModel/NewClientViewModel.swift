//
//  NewClientViewModel.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 22/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NewClientViewModel: NewClientViewModelType {

    // MARK: - Private
    private let sceneCoordinator: SceneCoordinatorType
    private let clientStorageService: ClientStorageServiceType
    
    // Data from cells
    private var clientDetailsModel: ClientDetailsModel?
    private var clientAddressModel: ClientAddressModel?
    
    
    // MARK: - Inits
    init(sceneCoordinator: SceneCoordinatorType, clientStorageService: ClientStorageServiceType) {
        self.sceneCoordinator = sceneCoordinator
        self.clientStorageService = clientStorageService
    }
}

extension NewClientViewModel {
        
    func createNewClient() {
        guard let clientDetails = clientDetailsModel, let clientAddress = clientAddressModel else { return }
        let clientUniqueID = UUID().uuidString
        let client = ClientModel(name: clientDetails.name, email: clientDetails.email, phone: clientDetails.phone, address: clientAddress.address, postcode: clientAddress.postcode, city: clientAddress.city, country: clientAddress.country, id: clientUniqueID)
        clientStorageService.addClient(client: client)
    }
    
    func getNewClientDetailModel(clientDetails: ClientDetailsModel) {
        clientDetailsModel = clientDetails
    }
    
    func getNewClientAddressModel(clientAddress: ClientAddressModel) {
        clientAddressModel = clientAddress
    }
    
    func popToClientsList(source: UIViewController) {
        sceneCoordinator.pop(source: source , animated: true)
    }
}