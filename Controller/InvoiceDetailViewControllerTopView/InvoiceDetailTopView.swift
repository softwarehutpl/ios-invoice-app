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
    
    func loadData(topviewdata: TopViewData) {
        dateLabel.text = topviewdata.date
        amountLabel.text = ("PLN \(topviewdata.amount)")
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

