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
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    
    func viewSetup() {
        amount.layer.borderWidth = 1
        amount.layer.borderColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
    }
    
    override func prepareForReuse() {
        invoiceTitle.text = ""
        clientName.text = ""
        date.text = ""
        amount.text = ""
    }
    
    func prepareCell(invoice: InvoiceModel) {
        invoiceTitle.text = invoice.title
        clientName.text = invoice.clientName
        date.text = invoice.date
        amount.text = invoice.amount
        if invoice.status == true {
            amount.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        } else {
            amount.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSetup()
    }
}

