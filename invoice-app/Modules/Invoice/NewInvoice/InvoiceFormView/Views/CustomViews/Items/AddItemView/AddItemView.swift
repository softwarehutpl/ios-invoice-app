//
//  AddItemView.swift
//  invoice-app
//
//  Created by Damian Szejnoch on 18/09/2019.
//  Copyright © 2019 Softwarehut. All rights reserved.
//

import UIKit

class AddItemView: NibLoadingView {
    
    var callback: (() -> Void)?
    
    @IBOutlet var contentView: UIView!
    
    @IBAction func addRowTapped(_ sender: UIButton) {
        callback?()
    }
}
