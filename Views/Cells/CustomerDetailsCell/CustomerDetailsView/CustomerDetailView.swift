//
//  CustomerDetailView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 13/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class CustomerDetailView: NibLoadingView {
    
    var changeTitle: (() -> Void)?
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet var contentView: UIView!
    
    func prepareView(client: ClientModel) {
        name.text = client.name
        email.text = client.email
        phone.text = client.phone
    }
}
