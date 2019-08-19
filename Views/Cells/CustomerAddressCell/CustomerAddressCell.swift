//
//  CustomerAddressCell.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 14/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class CustomerAddressCell: UITableViewCell {
    
    @IBOutlet weak var customView: CustomerAddressView!
    static let identyfier = "CustomerAddressCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func prepareView(customer: Customer) {
        customView.prepareView(customer: customer)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
