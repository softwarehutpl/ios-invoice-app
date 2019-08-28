//
//  NewClientAddressTableViewCell.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 23/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class NewClientAddressTableViewCell: UITableViewCell {
    
    var callback: ((NewClientAddressModel)->Void)?
    @IBOutlet weak var customView: NewClientAddressView!
    static let identyfier = "NewClientAddressTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customView.callback = { clientAddress in
            self.callback?(clientAddress)
        }
    }
}

