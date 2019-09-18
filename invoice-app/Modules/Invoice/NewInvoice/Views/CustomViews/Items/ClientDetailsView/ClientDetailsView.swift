//
//  ClientDetails.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 21/08/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import Foundation
import UIKit

class ClientDetailsView: NibLoadingView {
    
    var callback: (() -> Void)?
    
    // MARK: - Outlets
    @IBOutlet weak var clientName: UILabel!
    @IBOutlet weak var clientAddress: UILabel!
    @IBOutlet weak var clientEmail: UILabel!
    @IBOutlet weak var clientPhone: UILabel!
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var rightEditButton: UIButton!
    
    // Mark: - Setup View
    func prepareView(client: ClientModel) {
        self.clientName.text = client.name
        self.clientAddress.text = client.address
        self.clientEmail.text = client.email
        self.clientPhone.text = client.phone
    }
    
    private func setupOutlets() {
        rightEditButton.tintColor = #colorLiteral(red: 0.1136931852, green: 0.4413411915, blue: 0.3557595909, alpha: 1)
    }
    
    // Mark: - Actions
    @IBAction func rightEditButtonTap(_ sender: UIButton) {
        callback?()
    }
    
    // Mark: - Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupOutlets()
    }
}
