//
//  invoiceForm.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 19/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class InvoiceForm: UIView {
    
    var callback: ((InvoiceFormModel) -> Void)?
    
    // MARK: - Outets
    @IBOutlet weak var invoiceTitle: UITextField!
    @IBOutlet weak var invoiceDate: UITextField!
    @IBOutlet weak var invoiceDueDate: UITextField!
    @IBOutlet weak var invoiceAmount: UITextField!
    @IBOutlet var contentView: UIView!
    
    private func textFieldDelegate() {
        invoiceTitle.delegate = self
        invoiceDate.delegate = self
        invoiceDueDate.delegate = self
        invoiceAmount.delegate = self
    }
    // MARK: - Actions
    private func setupTextFieldIcons() {
        invoiceTitle.setIcon(#imageLiteral(resourceName: "editbutton"), iconColor: #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1))
        invoiceDate.setIcon(#imageLiteral(resourceName: "editbutton"), iconColor: #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1))
        invoiceDueDate.setIcon(#imageLiteral(resourceName: "editbutton"), iconColor: #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1))
        invoiceAmount.setIcon(#imageLiteral(resourceName: "editbutton"), iconColor: #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1))
    }
    private func addShadowToViews(views: [UITextField]) {
        views.forEach { (view) in
            view.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 2.0, opacity: 0.35)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setupTextFieldIcons()
        textFieldDelegate()
        addShadowToViews(views: [invoiceTitle,invoiceDate,invoiceDueDate,invoiceAmount])
        
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

extension InvoiceForm: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let invoiceTitle = invoiceTitle.text,
            let invoiceDate = invoiceDate.text,
            let invoiceDueDate = invoiceDueDate.text,
            let invoiceAmount = invoiceAmount.text
            else { return }
        let invoiceForm = InvoiceFormModel(invoiceTitle: invoiceTitle, date: invoiceDate, dueDate: invoiceDueDate, amount: invoiceAmount)
        callback?(invoiceForm)
    }
}
