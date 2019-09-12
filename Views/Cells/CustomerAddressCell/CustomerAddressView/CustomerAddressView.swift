//
//  CustomerAddressView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 14/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class CustomerAddressView: NibLoadingView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var address: UITextField!
    // MARK: OUTLETS
    
    func prepareView(client: ClientModel) {
        address.text = ("\(client.address), \(client.city), \(client.country)")
    }
}
