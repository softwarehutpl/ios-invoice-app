//
//  InvoiceCollectionViewCell.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 16/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class InvoiceCollectionViewCell: UICollectionViewCell {
    
    static var identyfier: String {
        return String(describing: self)
    }
    @IBOutlet weak var customView: InvoiceCellView!
    
    
    func prepareCell(invoice: InvoiceModel) {
        customView.prepareView(invoice: invoice)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
