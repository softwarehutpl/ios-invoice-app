//
//  invoiceForm.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 19/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class InvoiceForm: NibLoadingView {
    
    var passInvoiceForm: ((InvoiceFormModel) -> Void)?
    
    // MARK: - Picker Values
    let currencies = ["PLN", "USD", "EUR", "GBP", "CHF"]
    let paymentMethods = ["Cash","Credit Card", "Pay Pal", "Bank Transfer", "Other"]
    
    // MARK: - Outlets
    let dateFormatter = DateFormatter()
    let datePicker = UIDatePicker()
    
    let currencyPicker = UIPickerView()
    let paymentPicker = UIPickerView()
    
    @IBOutlet weak var invoiceTitle: UITextField!
    @IBOutlet weak var invoiceDate: UITextField!
    @IBOutlet weak var invoiceDueDate: UITextField!
    @IBOutlet weak var invoicePaymentMethod: UITextField!
    @IBOutlet weak var invoiceCurrency: UITextField!
    @IBOutlet var contentView: UIView!
    
    private func textFieldDelegate() {
        invoiceTitle.delegate = self
        invoiceDate.delegate = self
        invoiceDueDate.delegate = self
        invoicePaymentMethod.delegate = self
        invoiceCurrency.delegate = self
    }
    
    // MARK: - Setup Pickers

    func createCurrencyPicker() {
        invoiceCurrency.inputView = currencyPicker
        invoicePaymentMethod.inputView = paymentPicker
        currencyPicker.delegate = self
        paymentPicker.delegate = self
    }
    private func createDatePicker() {
        datePicker.datePickerMode = .date
        invoiceDate.inputView = datePicker
        invoiceDueDate.inputView = datePicker
        datePicker.timeZone = NSTimeZone.local
        datePicker.backgroundColor = UIColor.white
    }
    
    // MARK: - Setup Views
    private func addShadowToViews(views: [UITextField]) {
        views.forEach { (view) in
            view.addShadow(offset: CGSize.init(width: 0, height: 1), color: UIColor.gray, radius: 2.0, opacity: 0.35)
        }
    }
    
    //MARK: - Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCurrencyPicker()
        createDatePicker()
        textFieldDelegate()
        addShadowToViews(views: [invoiceTitle,invoiceDate,invoiceDueDate,invoicePaymentMethod,invoiceCurrency])
    }
}

extension InvoiceForm: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let invoiceTitle = invoiceTitle.text,
            let invoiceDate = invoiceDate.text,
            let invoiceDueDate = invoiceDueDate.text,
            let invoicePaymentMethod = invoicePaymentMethod.text,
            let invoiceCurrency = invoiceCurrency.text
            else { return }
        
        let invoiceForm = InvoiceFormModel(invoiceTitle: invoiceTitle, date: invoiceDate, dueDate: invoiceDueDate, paymentMethod: invoicePaymentMethod, currency: invoiceCurrency)
        passInvoiceForm?(invoiceForm)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if invoiceDate.text == nil || invoiceDate.text?.isEmpty ?? false && invoiceDueDate.text == nil || invoiceDueDate.text?.isEmpty ?? false {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            invoiceDate.text = dateFormatter.string(from: Date())
            guard let proposedDate = Calendar.current.date(byAdding: .day, value: 14, to: Date()) else { return }
            invoiceDueDate.text = dateFormatter.string(from: proposedDate)
            invoicePaymentMethod.text = "Credit Card"
            invoiceCurrency.text = "PLN"
        }
    }
}

extension InvoiceForm: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == paymentPicker {
            return paymentMethods.count
        }
        else {
            return currencies.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == currencyPicker {
            return currencies[row]
        }
        else {
            return paymentMethods[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == paymentPicker {
            invoicePaymentMethod.text = paymentMethods[row]
            invoicePaymentMethod.delegate = nil
        }
        else {
            invoiceCurrency.text = currencies[row]
            invoiceCurrency.delegate = nil
        }
    }
}
