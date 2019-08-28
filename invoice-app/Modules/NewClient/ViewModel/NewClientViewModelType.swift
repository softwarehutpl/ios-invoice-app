//
//  NewClientViewModelType.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 22/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//
import UIKit

protocol NewClientViewModelType {
    func createNewClient(client: ClientModel,source: UIViewController)
}
