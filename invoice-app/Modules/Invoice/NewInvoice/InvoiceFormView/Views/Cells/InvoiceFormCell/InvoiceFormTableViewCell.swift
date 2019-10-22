//
//  InvoiceFormTableViewCell.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 24/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class InvoiceFormTableViewCell: UITableViewCell {
    
    var passInvoiceForm: ((InvoiceFormModel) -> Void)?
    static let identyfier = "InvoiceFormTableViewCell"
    
    // Mark: - Outlets
    @IBOutlet weak var customView: InvoiceForm!
    
    func prepareCell(invoiceForm: InvoiceFormModel) {
        customView.prepareView(invoiceForm: invoiceForm)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        customView.passInvoiceForm = { [weak self] invoiceForm in
            guard let `self` = self else { return }
            self.passInvoiceForm?(invoiceForm)
        }
    }
}
