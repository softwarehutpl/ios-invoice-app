//
//  InvoiceFormTableViewCell.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 24/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class InvoiceFormTableViewCell: UITableViewCell {
    
    var callback: ((InvoiceFormModel) -> Void)?
    static let identyfier = "InvoiceFormTableViewCell"
    
    // Mark: - Outlets
    @IBOutlet weak var customView: InvoiceForm!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customView.callback = { invoiceForm in
            self.callback?(invoiceForm)
        }
    }
}
