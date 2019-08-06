//
//  InvoiceCollectionViewCell.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 06/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit


class InvoiceCollectionViewCell: UICollectionViewCell {
    
    static let identyfier = "InvoiceCollectionViewCell"
    @IBOutlet weak var invoiceTitle: UILabel!
    @IBOutlet weak var invoicePrice: UILabel!
    
    override func prepareForReuse() {
        invoiceTitle.text = ""
        invoicePrice.text = ""
    }
    
    func prepareCell(invoice: InvoiceModel) {
        invoiceTitle.text = invoice.name
        invoicePrice.text = invoice.price
    }
}
