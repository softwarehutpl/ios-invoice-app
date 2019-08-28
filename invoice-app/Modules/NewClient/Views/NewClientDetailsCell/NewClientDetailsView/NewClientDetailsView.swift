//
//  NewClientDetailsView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 23/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//
import UIKit

class NewClientDetailsView: UIView {
    
    var callback: ((NewClientDetailModel) -> Void)?
    //MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var clientName: UITextField!
    @IBOutlet weak var clientEmail: UITextField!
    @IBOutlet weak var clientPhone: UITextField!
    
    //MARK: Loading Data
    private func textFieldDelegate() {
        clientName.delegate = self
        clientEmail.delegate = self
        clientPhone.delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        textFieldDelegate()
    }
    
    private func commonInit() {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "NewClientDetailsView", bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
}

extension NewClientDetailsView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let clientName = clientName.text,
                let clientEmail = clientEmail.text,
                let clientPhone = clientPhone.text else { return }
        let client = NewClientDetailModel(name: clientName, email: clientEmail, phone: clientPhone)
        callback?(client)
    }
}
