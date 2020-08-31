//
//  NewInvoiceCellHeader.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 18/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class NewInvoiceCellHeader: NibLoadingView {
    
    var callback: (() -> Void)?
    
    //MARK: - Outlets
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var edit: UIButton!
    @IBAction func editButton(_ sender: UIButton) {
        callback?()
    }
}
