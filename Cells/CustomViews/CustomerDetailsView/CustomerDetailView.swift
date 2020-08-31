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
    
   
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet var contentView: UIView!
    
    func prepareView(client: ClientModel) {
        name.text = client.name
        email.text = client.email
        phone.text = client.phone
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        name.layer.borderWidth = 0
        email.layer.borderWidth = 0
        phone.layer.borderWidth = 0
    }
}
