//
//  InvoiceCollectionViewCell.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 06/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit


class InvoiceCollectionViewCell: UICollectionViewCell {
    
    // Cell id
    static let identyfier = "InvoiceCollectionViewCell"
    
    @IBOutlet weak var invoiceTitle: UILabel!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var amount: EdgeInsetLabel!
    
    // UI Setup
    func viewSetup() {
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        amount.textInsets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
        amount.layer.borderWidth = 1
        amount.layer.borderColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
    }
    
    override func prepareForReuse() {
        clientName.text = ""
        date.text = ""
        amount.text = ""
    }
    
    func prepareCell(invoice: InvoiceModel) {
        clientName.text = invoice.client.name
        date.text = invoice.date
        amount.text = ("PLN \(invoice.amount)")
        if invoice.status == true {
            amount.textColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
            amount.layer.borderColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
            amount.layer.allowsEdgeAntialiasing = true
            
        } else {
            amount.textColor = #colorLiteral(red: 0.6614252855, green: 0.0989431448, blue: 0.005714571283, alpha: 1)
            amount.layer.borderColor = #colorLiteral(red: 0.6614252855, green: 0.0989431448, blue: 0.005714571283, alpha: 1)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSetup()
    }
}

