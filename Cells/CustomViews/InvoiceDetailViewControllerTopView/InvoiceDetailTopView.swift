//
//  InvoiceDetailViewTopView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 12/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class InvoiceDetailTopView: UIView {
    
    @IBOutlet weak var invoiceTitle: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var dueDate: UILabel!
    @IBOutlet weak var totalWithTax: UILabel!
    
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func loadData(invoice: InvoiceModel) {
        
        // counted data
        var countedTotal = 0.0
        
        invoice.items.forEach { (item) in
            guard let amount = Double(item.amount) else { return }
            guard let price = Double(item.price) else { return }
            countedTotal += amount * price
        }
        startDate.text = invoice.date
        dueDate.text = invoice.dueDate
        totalWithTax.text = ("PLN \(countedTotal)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "InvoiceDetailTopView", bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
}

