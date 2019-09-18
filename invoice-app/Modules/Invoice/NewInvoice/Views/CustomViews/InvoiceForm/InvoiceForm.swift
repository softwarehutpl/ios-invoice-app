//
//  invoiceForm.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 19/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class InvoiceForm: NibLoadingView {
    
    var callback: ((InvoiceFormModel) -> Void)?
    
    // MARK: - Outlets
    let dateFormatter = DateFormatter()
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var invoiceTitle: UITextField!
    @IBOutlet weak var invoiceDate: UITextField!
    @IBOutlet weak var invoiceDueDate: UITextField!
    @IBOutlet weak var invoiceAmount: UITextField!
    @IBOutlet weak var currency: UITextField!
    @IBOutlet var contentView: UIView!
    
    private func textFieldDelegate() {
        invoiceTitle.delegate = self
        invoiceDate.delegate = self
        invoiceDueDate.delegate = self
        invoiceAmount.delegate = self
        currency.delegate = self
    }
    
    // MARK: - Setup Views
    private func createDatePicker() {
        datePicker.datePickerMode = .date
        invoiceDate.inputView = datePicker
        invoiceDueDate.inputView = datePicker
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
    }
    
    private func addShadowToViews(views: [UITextField]) {
        views.forEach { (view) in
            view.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 2.0, opacity: 0.35)
        }
    }
    
    //MARK: - Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createDatePicker()
        textFieldDelegate()
        addShadowToViews(views: [invoiceTitle,invoiceDate,invoiceDueDate,invoiceAmount,currency])
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

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if invoiceDate.text == nil || invoiceDate.text?.isEmpty ?? false && invoiceDueDate.text == nil || invoiceDueDate.text?.isEmpty ?? false {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            invoiceDate.text = dateFormatter.string(from: Date())
            guard let proposedDate = Calendar.current.date(byAdding: .day, value: 14, to: Date()) else { return }
            invoiceDueDate.text = dateFormatter.string(from: proposedDate)
        }
    }
}
