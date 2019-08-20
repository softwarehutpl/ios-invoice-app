//
//  invoiceForm.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 19/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class InvoiceForm: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var companyDetailsView: UIView!
    @IBOutlet weak var clientDetailsView: UIView!
    @IBOutlet weak var invoiceDetailsView: UIView!
    @IBOutlet weak var itemsDetailsView: UIView!
    
    @IBOutlet weak var companyName: CustomTextField!
    @IBOutlet weak var companyAddress: CustomTextField!
    @IBOutlet weak var clientName: CustomTextField!
    @IBOutlet weak var clientAddress: CustomTextField!
    @IBOutlet weak var clientEmail: CustomTextField!
    @IBOutlet weak var clientPhone: CustomTextField!
    @IBOutlet weak var invoiceTitle: CustomTextField!
    @IBOutlet weak var invoiceDate: CustomTextField!
    @IBOutlet weak var invoiceDueDate: CustomTextField!
    
    
    func addShadowToViews(views: [UIView]) {
        views.forEach { (view) in
            view.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 2.0, opacity: 0.35)
        }
    }
    
    @IBAction func addInvoice(_ sender: UIButton) {
        print("added invoice")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        addShadowToViews(views: [companyDetailsView,clientDetailsView,invoiceDetailsView,itemsDetailsView])
    }
    
    private func commonInit() {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "InvoiceForm", bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
}
