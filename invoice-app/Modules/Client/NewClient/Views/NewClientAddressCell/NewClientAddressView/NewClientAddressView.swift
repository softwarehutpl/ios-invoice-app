//
//  NewClientAddressView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 23/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class NewClientAddressView: NibLoadingView {
    
    var callback: ((ClientAddressModel) -> Void)?
    
    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var postcode: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var country: UITextField!
    
    func textFieldDelegate() {
        address.delegate = self
        postcode.delegate = self
        city.delegate = self
        country.delegate = self
    }
    // MARK: - Setup View
    private func addShadowToViews(views: [UITextField]) {
        views.forEach { (view) in
            view.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 2.0, opacity: 0.35)
        }
    }
    
    func prepareView(clientAddress: ClientAddressModel) {
        address.text = clientAddress.address
        postcode.text = clientAddress.postcode
        city.text = clientAddress.city
        country.text = clientAddress.country
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textFieldDelegate()
        addShadowToViews(views: [address,postcode,city,country])
    }
    
}

extension NewClientAddressView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let address = address.text,
            let postcode = postcode.text,
            let city = city.text,
            let country = country.text else { return }
        let clientAddress = ClientAddressModel(address: address, postcode: postcode, city: city, country: country)
        callback?(clientAddress)
    }
}
