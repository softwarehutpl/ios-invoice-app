//
//  NewClientAddressView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 23/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class NewClientAddressView: UIView {
    
    var callback: ((NewClientAddressModel) -> Void)?
    
    //MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var postcode: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var country: UITextField!
    
    //MARK: Loading Data
    func textFieldDelegate() {
        address.delegate = self
        postcode.delegate = self
        city.delegate = self
        country.delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        textFieldDelegate()
    }
    
    private func commonInit() {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "NewClientAddressView", bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
}

extension NewClientAddressView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let address = address.text,
            let postcode = postcode.text,
            let city = city.text,
            let country = country.text else { return }
        let clientAddress = NewClientAddressModel(address: address, postcode: postcode, city: city, country: country)
        callback?(clientAddress)
    }
}
