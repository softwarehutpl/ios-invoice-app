//
//  InvoiceDetailViewTopView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 12/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class InvoiceDetailTopView: UIView {
    
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet var contentView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func loadData(invoice: InvoiceModel) {
        dateLabel.text = invoice.dueDate
        amountLabel.text = ("PLN \(invoice.currency)")
        contentView.backgroundColor = invoice.status == true ? #colorLiteral(red: 0.1453877687, green: 0.4133757949, blue: 0.3077362776, alpha: 1) : #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
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

