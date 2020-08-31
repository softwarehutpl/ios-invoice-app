//
//  NewClientDetailsView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 23/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//
import UIKit

class NewClientDetailsView: NibLoadingView {
    
    var callback: ((ClientDetailsModel) -> Void)?
    
    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var clientName: UITextField!
    @IBOutlet weak var clientEmail: UITextField!
    @IBOutlet weak var clientPhone: UITextField!
    
    private func textFieldDelegate() {
        clientName.delegate = self
        clientEmail.delegate = self
        clientPhone.delegate = self
    }
    
    // MARK: Setup View
    private func addShadowToViews(views: [UITextField]) {
        views.forEach { (view) in
            view.addShadow(offset: CGSize.init(width: 0, height: 1), color: UIColor.gray, radius: 2.0, opacity: 0.35)
        }
    }
    
    func prepareView(clientDetails: ClientDetailsModel) {
        self.clientName.text = clientDetails.name
        self.clientEmail.text = clientDetails.email
        self.clientPhone.text = clientDetails.phone
    }
    
    // MARK: - Lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textFieldDelegate()
        addShadowToViews(views: [clientName,clientEmail,clientPhone])
    }
    
}

extension NewClientDetailsView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let clientName = clientName.text,
                let clientEmail = clientEmail.text,
                let clientPhone = clientPhone.text else { return }
        let client = ClientDetailsModel(name: clientName, email: clientEmail, phone: clientPhone)
        callback?(client)
    }
}
