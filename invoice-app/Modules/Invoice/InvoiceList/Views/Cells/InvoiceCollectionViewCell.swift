//
//  InvoiceCollectionViewCell.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 16/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class InvoiceCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var customView: InvoiceCellView!
    
    static let identyfier = "InvoiceCollectionViewCell"
    
    func prepareCell(invoice: InvoiceModel) {
        customView.prepareView(invoice: invoice)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
