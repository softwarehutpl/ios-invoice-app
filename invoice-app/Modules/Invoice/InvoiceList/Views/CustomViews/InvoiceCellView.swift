//
//  InvoiceCellView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 16/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class InvoiceCellView: NibLoadingView {
    
    static let identyfier = "InvoiceCellView"
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var invoiceTitle: UILabel!
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var status: EdgeInsetLabel!
    
    func prepareView(invoice: InvoiceModel) {
        invoiceTitle.text = invoice.invoiceTitle
        clientName.text = invoice.client.name
        amount.text = invoice.amount
        dueDate.text = invoice.dueDate
        status.backgroundColor = invoice.status ? #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1) : #colorLiteral(red: 0.7476998731, green: 0, blue: 0.05588565574, alpha: 1)
        status.text = invoice.status ? "Paid" : "Unpaid"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}